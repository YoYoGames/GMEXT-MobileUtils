#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <objc/runtime.h>

#import "GMLocalNotifications_ios.h"

/**
 * Extension Generator conversion of MobileUtils_LocalNotifications.
 *
 * The legacy YYLocalNotifications reported notification arrival and permission
 * results through the async Social event. This version returns everything
 * through GMFunction callbacks instead:
 *
 *     set_listener(callback)         -> callback(identifier, title, message, data, image_path)
 *     request_permission(callback)   -> callback(granted, error)
 *     permission_status(callback)    -> callback(status)
 *
 * Coexistence with YYFirebaseCloudMessaging:
 *   Both extensions swizzle the same two UNUserNotificationCenterDelegate
 *   selectors on iPad_RunnerAppDelegate. We use DISTINCT swizzled selector
 *   names (gmln_...) and a chaining swizzle so both implementations run in any
 *   load order. We handle only LOCAL notifications (non UNPushNotificationTrigger);
 *   FCM handles only remote ones, so neither double-handles.
 */

// Notification identifiers are namespaced with this prefix so cancelling /
// reporting only touches notifications scheduled by this extension.
static NSString *const kGMLNPrefix = @"GMLocalNotification";

// Persistent listener invoked every time a local notification is presented or tapped.
static gm::wire::GMFunction g_notificationListener = nil;

// Notifications received before a listener is registered (e.g. a tap that
// cold-started the app) are queued here and flushed once a listener is set.
static NSMutableArray<NSDictionary<NSString *, NSString *> *> *g_pendingNotifications = nil;

// Dedupe the foreground present + tap pair: willPresent and then didReceive both
// fire for the same notification within a moment. Android delivers once, so we
// suppress the second delivery within a short window (a genuine later re-fire of
// the same id still gets through).
static NSString *g_lastHandledIdentifier = nil;
static NSTimeInterval g_lastHandledTime = 0;
static const NSTimeInterval kNotificationDedupeWindow = 3.0;

typedef void(^RunOnceCompletionHandler)(void);
typedef void(^RunOncePresentationHandler)(UNNotificationPresentationOptions options);

// Wrap a "void(void)" completion handler so it only runs once
static void(^RunOnceVoidCompletionHandler(void(^originalHandler)(void)))(void) {
    __block BOOL called = NO;
    return ^{
        if (!called) {
            called = YES;
            if (originalHandler) originalHandler();
        }
    };
}

// Wrap a "(UNNotificationPresentationOptions)" completion handler so it only runs once
static void(^RunOncePresentationCompletionHandler(void(^originalHandler)(UNNotificationPresentationOptions)))(UNNotificationPresentationOptions) {
    __block BOOL called = NO;
    return ^(UNNotificationPresentationOptions options){
        if (!called) {
            called = YES;
            if (originalHandler) originalHandler(options);
        }
    };
}

@implementation GMLocalNotifications

#pragma mark - App delegate swizzling

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Resolve the runner app delegate at runtime; its header is not on the
        // extension build's include path.
        Class appDelegateClass = NSClassFromString(@"iPad_RunnerAppDelegate");
        if (appDelegateClass == Nil) {
            NSLog(@"[GMLocalNotifications] Could not find iPad_RunnerAppDelegate.");
            return;
        }

        class_addProtocol(appDelegateClass, @protocol(UNUserNotificationCenterDelegate));
        [self swizzleUserNotificationMethodsForClass:appDelegateClass];

        // Earliest reliable hook that does not depend on the runner instantiating
        // our extension object: set the delegate when the app finishes launching.
        [[NSNotificationCenter defaultCenter]
            addObserverForName:UIApplicationDidFinishLaunchingNotification
                        object:nil
                         queue:nil
                    usingBlock:^(NSNotification * _Nonnull note) {
            [GMLocalNotifications ensureNotificationDelegate];
        }];
    });
}

+ (void)swizzleUserNotificationMethodsForClass:(Class)appDelegateClass {

    // willPresentNotification
    [self swizzleMethodInClass:appDelegateClass
              originalSelector:@selector(userNotificationCenter:willPresentNotification:withCompletionHandler:)
              swizzledSelector:@selector(gmln_userNotificationCenter:willPresentNotification:withCompletionHandler:)];

    // didReceiveNotificationResponse
    [self swizzleMethodInClass:appDelegateClass
              originalSelector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)
              swizzledSelector:@selector(gmln_userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)];

    // didFinishLaunchingWithOptions — so we can assign the notification center
    // delegate before launch completes, which is required for iOS to deliver a
    // notification tap that cold-started the app.
    [self swizzleMethodInClass:appDelegateClass
              originalSelector:@selector(application:didFinishLaunchingWithOptions:)
              swizzledSelector:@selector(gmln_application:didFinishLaunchingWithOptions:)];
}

// Chaining swizzle: when the target already implements the original selector
// (e.g. another extension installed it), copy that implementation onto our
// swizzled selector before exchanging, so calling the swizzled selector invokes
// the previously installed handler.
+ (void)swizzleMethodInClass:(Class)targetClass
            originalSelector:(SEL)originalSelector
            swizzledSelector:(SEL)swizzledSelector {

    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (swizzledMethod == NULL) {
        NSLog(@"[GMLocalNotifications] Missing swizzled method %@.", NSStringFromSelector(swizzledSelector));
        return;
    }

    BOOL added = class_addMethod(targetClass,
                                 originalSelector,
                                 method_getImplementation(swizzledMethod),
                                 method_getTypeEncoding(swizzledMethod));

    if (added) {
        // Nothing previously implemented the original selector; our IMP is now installed.
        return;
    }

    // Something already implements the original selector. Preserve it under our
    // swizzled selector, then exchange so the original points at our handler and
    // our swizzled selector points at the previous handler (the chain).
    Method installedMethod = class_getInstanceMethod(targetClass, originalSelector);
    if (installedMethod == NULL) {
        NSLog(@"[GMLocalNotifications] Could not find original method %@.", NSStringFromSelector(originalSelector));
        return;
    }

    // Install OUR implementation under the swizzled selector before exchanging,
    // so afterwards the original selector runs our handler and the swizzled
    // selector chains to the previously installed one. Adding installedMethod's
    // IMP here instead would leave both selectors pointing at the previous
    // implementation and our handler would never run.
    class_addMethod(targetClass,
                    swizzledSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));

    Method replacementMethod = class_getInstanceMethod(targetClass, swizzledSelector);
    method_exchangeImplementations(installedMethod, replacementMethod);
}

#pragma mark - Swizzled notification methods

// Swizzled willPresentNotification
- (void)gmln_userNotificationCenter:(UNUserNotificationCenter *)center
            willPresentNotification:(UNNotification *)notification
              withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {

    void (^onceHandler)(UNNotificationPresentationOptions) = RunOncePresentationCompletionHandler(completionHandler);

    // Call the chained previous implementation if one exists.
    if ([self respondsToSelector:@selector(gmln_userNotificationCenter:willPresentNotification:withCompletionHandler:)]) {
        [self gmln_userNotificationCenter:center willPresentNotification:notification withCompletionHandler:onceHandler];
    }

    UNNotificationPresentationOptions presentOptions;
    if (@available(iOS 14.0, *)) {
        presentOptions = UNNotificationPresentationOptionBanner | UNNotificationPresentationOptionList | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge;
    } else {
        presentOptions = UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge;
    }

    UNNotificationTrigger *trigger = notification.request.trigger;

    // Remote notifications are owned by whoever registered for push (FCM, or the
    // sibling APN extension); we don't deliver them to the local listener. But we
    // must still call the completion handler or iOS suppresses the foreground
    // presentation and logs "completion handler not called". The run-once wrapper
    // keeps this safe when a chained handler already called it.
    if ([trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        onceHandler(presentOptions);
        return;
    }

    [GMLocalNotifications handleLocalNotification:notification];

    onceHandler(presentOptions);
}

// Swizzled didReceiveNotificationResponse
- (void)gmln_userNotificationCenter:(UNUserNotificationCenter *)center
     didReceiveNotificationResponse:(UNNotificationResponse *)response
              withCompletionHandler:(void (^)(void))completionHandler {

    void (^onceHandler)(void) = RunOnceVoidCompletionHandler(completionHandler);

    if ([self respondsToSelector:@selector(gmln_userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]) {
        [self gmln_userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:onceHandler];
    }

    UNNotification *notification = response.notification;
    UNNotificationTrigger *trigger = notification.request.trigger;

    if ([trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        onceHandler();
        return;
    }

    [GMLocalNotifications handleLocalNotification:notification];

    onceHandler();
}

// Swizzled didFinishLaunchingWithOptions
- (BOOL)gmln_application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Assign the notification center delegate BEFORE the runner's launch runs.
    // The runner's didFinishLaunching boots and spins the game loop, during
    // which iOS may deliver a cold-start notification response; the delegate has
    // to be in place first or that response is lost.
    [GMLocalNotifications ensureNotificationDelegate];

    BOOL result = YES;

    // Chain to the previously installed implementation (the runner's) if present.
    if ([self respondsToSelector:@selector(gmln_application:didFinishLaunchingWithOptions:)]) {
        result = [self gmln_application:application didFinishLaunchingWithOptions:launchOptions];
    }

    return result;
}

// Runner lifecycle hook, invoked on the extension object during app launch (the
// same hook FCM uses). Guarantees the delegate is set during launch even if the
// runner instantiates the extension object lazily rather than via the swizzle.
- (void)onLaunch:(NSDictionary *)launchOptions {
    [GMLocalNotifications ensureNotificationDelegate];
}

#pragma mark - Extension init

- (instancetype)init {
    self = [super init];

    // Fallback: ensure the delegate is set when the extension object is created
    // (covers app states other than a cold start).
    [GMLocalNotifications ensureNotificationDelegate];

    return self;
}

// Assigns the runner app delegate as the notification center delegate. Idempotent
// and safe to call from multiple launch hooks; the app delegate carries the
// swizzled UN delegate methods. Setting the same value repeatedly is harmless and
// coexists with FCM (which assigns the same app delegate).
+ (void)ensureNotificationDelegate {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if (appDelegate == nil) {
        return;
    }
    UNUserNotificationCenter.currentNotificationCenter.delegate =
        (id<UNUserNotificationCenterDelegate>)appDelegate;
}

#pragma mark - Generator API

- (void)mobile_utils_notification_create:(std::string_view)identifier
                                 seconds:(double)seconds
                                   title:(std::string_view)title
                                 message:(std::string_view)message
                                    data:(std::string_view)data {

    [self scheduleNotificationWithIdentifier:identifier
                                     seconds:seconds
                                       title:title
                                     message:message
                                        data:data
                                  image_path:std::string_view()];
}

- (void)mobile_utils_notification_create_ext:(std::string_view)identifier
                                     seconds:(double)seconds
                                       title:(std::string_view)title
                                     message:(std::string_view)message
                                        data:(std::string_view)data
                                  image_path:(std::string_view)image_path {

    [self scheduleNotificationWithIdentifier:identifier
                                     seconds:seconds
                                       title:title
                                     message:message
                                        data:data
                                  image_path:image_path];
}

- (void)mobile_utils_notification_cancel:(std::string_view)identifier {
    NSString *prefixedId = [self prefixedIdentifier:identifier];

    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removePendingNotificationRequestsWithIdentifiers:@[prefixedId]];
}

- (void)mobile_utils_notification_set_listener:(gm::wire::GMFunction)callback {
    g_notificationListener = callback;

    // Deliver any notifications that arrived before the listener was registered
    // (e.g. a notification tap that cold-started the app).
    if (g_pendingNotifications.count > 0) {
        NSArray<NSDictionary<NSString *, NSString *> *> *pending = g_pendingNotifications;
        g_pendingNotifications = nil;
        for (NSDictionary<NSString *, NSString *> *info in pending) {
            [GMLocalNotifications deliverNotification:info];
        }
    }
}

- (void)mobile_utils_notification_request_permission:(gm::wire::GMFunction)callback {
    if (@available(iOS 10.0, *)) {
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
            requestAuthorizationWithOptions:authOptions
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
            std::string errorMessage = error.localizedDescription ? std::string(error.localizedDescription.UTF8String ?: "") : std::string();
            callback.call(granted ? true : false, errorMessage);
        }];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIUserNotificationType allTypes = (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        callback.call(true, std::string());
#pragma clang diagnostic pop
    }
}

- (void)mobile_utils_notification_permission_status:(gm::wire::GMFunction)callback {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings) {
        gm_enums::MobileUtilsNotificationPermission status = gm_enums::MobileUtilsNotificationPermission::Unknown;
        switch (settings.authorizationStatus) {
            case UNAuthorizationStatusAuthorized:    status = gm_enums::MobileUtilsNotificationPermission::Authorized;    break;
            case UNAuthorizationStatusDenied:        status = gm_enums::MobileUtilsNotificationPermission::Denied;        break;
            case UNAuthorizationStatusNotDetermined: status = gm_enums::MobileUtilsNotificationPermission::NotDetermined; break;
            case UNAuthorizationStatusProvisional:   status = gm_enums::MobileUtilsNotificationPermission::Provisional;   break;
            case UNAuthorizationStatusEphemeral:     status = gm_enums::MobileUtilsNotificationPermission::Ephemeral;     break;
            default: break;
        }
        callback.call(static_cast<std::int32_t>(status));
    }];
}

#pragma mark - Helpers

- (NSString *)prefixedIdentifier:(std::string_view)identifier {
    NSString *idString = [[NSString alloc] initWithBytes:identifier.data()
                                                  length:identifier.size()
                                                encoding:NSUTF8StringEncoding];
    return [kGMLNPrefix stringByAppendingString:(idString ?: @"")];
}

- (void)scheduleNotificationWithIdentifier:(std::string_view)identifier
                                  seconds:(double)seconds
                                    title:(std::string_view)title
                                  message:(std::string_view)message
                                     data:(std::string_view)data
                               image_path:(std::string_view)image_path {

    if (seconds <= 0) {
        return;
    }

    NSString *prefixedId = [self prefixedIdentifier:identifier];
    NSString *titleString = [[NSString alloc] initWithBytes:title.data() length:title.size() encoding:NSUTF8StringEncoding] ?: @"";
    NSString *messageString = [[NSString alloc] initWithBytes:message.data() length:message.size() encoding:NSUTF8StringEncoding] ?: @"";
    NSString *dataString = [[NSString alloc] initWithBytes:data.data() length:data.size() encoding:NSUTF8StringEncoding] ?: @"";

    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = titleString;
    content.body = messageString;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"data_key" : dataString};

    NSString *imagePathString = [[NSString alloc] initWithBytes:image_path.data() length:image_path.size() encoding:NSUTF8StringEncoding] ?: @"";
    UNNotificationAttachment *attachment = [GMLocalNotifications attachmentForImagePath:imagePathString];
    if (attachment != nil) {
        content.attachments = @[attachment];
    }

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:seconds repeats:NO];

    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removePendingNotificationRequestsWithIdentifiers:@[prefixedId]];

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:prefixedId content:content trigger:trigger];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"[GMLocalNotifications] Failed to schedule notification: %@", error.localizedDescription);
        }
    }];
}

// Build a notification image attachment from image_path (absolute, or relative to
// the Documents directory, matching how the rest of the extension resolves paths).
// The file is copied into the temp dir first because UNNotificationAttachment
// moves the source into its own data store. Returns nil when there is no usable
// image so the caller simply schedules without an attachment.
+ (UNNotificationAttachment *)attachmentForImagePath:(NSString *)imagePath {
    if (imagePath.length == 0) {
        return nil;
    }

    NSString *resolvedPath = imagePath;
    if (![imagePath hasPrefix:@"/"]) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        resolvedPath = [documentsPath stringByAppendingPathComponent:imagePath];
    }

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:resolvedPath]) {
        return nil;
    }

    NSString *extension = resolvedPath.pathExtension;
    NSString *tempName = [[NSUUID UUID] UUIDString];
    if (extension.length > 0) {
        tempName = [tempName stringByAppendingPathExtension:extension];
    }
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingPathComponent:tempName];

    if (![fileManager copyItemAtPath:resolvedPath toPath:tempPath error:nil]) {
        return nil;
    }

    NSError *attachmentError = nil;
    UNNotificationAttachment *attachment =
        [UNNotificationAttachment attachmentWithIdentifier:@"image"
                                                       URL:[NSURL fileURLWithPath:tempPath]
                                                   options:nil
                                                     error:&attachmentError];

    if (attachment == nil) {
        [fileManager removeItemAtPath:tempPath error:nil];
        return nil;
    }

    return attachment;
}

+ (void)handleLocalNotification:(UNNotification *)notification {
    NSString *rawIdentifier = notification.request.identifier ?: @"";

    // Suppress the present+tap duplicate (see g_lastHandledIdentifier).
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    if (g_lastHandledIdentifier != nil
        && [g_lastHandledIdentifier isEqualToString:rawIdentifier]
        && (now - g_lastHandledTime) < kNotificationDedupeWindow) {
        return;
    }
    g_lastHandledIdentifier = [rawIdentifier copy];
    g_lastHandledTime = now;

    NSString *identifier = rawIdentifier;
    if ([identifier hasPrefix:kGMLNPrefix]) {
        identifier = [identifier substringFromIndex:kGMLNPrefix.length];
    }

    NSDictionary<NSString *, NSString *> *info = @{
        @"id"      : identifier ?: @"",
        @"title"   : notification.request.content.title ?: @"",
        @"message" : notification.request.content.body ?: @"",
        @"data"    : notification.request.content.userInfo[@"data_key"] ?: @"",
        @"image"   : @"",
    };

    if (g_notificationListener) {
        [self deliverNotification:info];
        return;
    }

    // No listener yet (e.g. cold start from a tap). Queue until one registers.
    if (g_pendingNotifications == nil) {
        g_pendingNotifications = [NSMutableArray array];
    }
    [g_pendingNotifications addObject:info];
}

+ (void)deliverNotification:(NSDictionary<NSString *, NSString *> *)info {
    if (!g_notificationListener) {
        return;
    }

    g_notificationListener.call(
        std::string(info[@"id"].UTF8String ?: ""),
        std::string(info[@"title"].UTF8String ?: ""),
        std::string(info[@"message"].UTF8String ?: ""),
        std::string(info[@"data"].UTF8String ?: ""),
        std::string(info[@"image"].UTF8String ?: "")
    );
}

@end
