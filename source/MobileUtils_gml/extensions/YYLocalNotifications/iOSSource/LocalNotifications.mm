#import <objc/runtime.h>

#import "iPad_RunnerAppDelegate.h"
#import "LocalNotifications.h"

extern "C" int dsMapCreate();
extern "C" void dsMapAddInt(int _dsMap, char* _key, int _value);
extern "C" void dsMapAddDouble(int _dsMap, char* _key, double _value);
extern "C" void dsMapAddString(int _dsMap, char* _key, char* _value);
extern "C" void createSocialAsyncEventWithDSMap(int dsmapindex);
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);

const int EVENT_OTHER_SOCIAL = 70;
const int EVENT_OTHER_NOTIFICATION = 71;

static const void *kOnceTokenKey = &kOnceTokenKey;

typedef void(^RunOnceCompletionHandler)(void);
typedef void(^RunOncePresentationHandler)(UNNotificationPresentationOptions options);

// Wrap a "void(void)" completion handler so it only runs once
static void(^RunOnceVoidCompletionHandler(void(^originalHandler)(void)))(void) {
    __block BOOL called = NO;
    return ^{
        if (!called) {
            called = YES;
            if (originalHandler) originalHandler();
        } else {
            // Already called, do nothing
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
        } else {
            // Already called, do nothing
        }
    };
}

@implementation LocalNotifications

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        class_addProtocol([iPad_RunnerAppDelegate class], @protocol(UNUserNotificationCenterDelegate));
        [self swizzleUserNotificationMethods];
    });
}

+ (void)swizzleUserNotificationMethods {
    Class appDelegateClass = [iPad_RunnerAppDelegate class];

    // willPresentNotification
    [self swizzleMethodInClass:appDelegateClass
              originalSelector:@selector(userNotificationCenter:willPresentNotification:withCompletionHandler:)
              swizzledSelector:@selector(yy_userNotificationCenter:willPresentNotification:withCompletionHandler:)];

    // didReceiveNotificationResponse
    [self swizzleMethodInClass:appDelegateClass
              originalSelector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)
              swizzledSelector:@selector(yy_userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)];
}

+ (void)swizzleMethodInClass:(Class)appDelegateClass
            originalSelector:(SEL)originalSelector
            swizzledSelector:(SEL)swizzledSelector {

    Method originalMethod = class_getInstanceMethod(appDelegateClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);

    BOOL didAddMethod = class_addMethod(appDelegateClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        NSLog(@"[MobileUtils_APN] Added method %@ to class %@", NSStringFromSelector(originalSelector), NSStringFromClass(appDelegateClass));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
        NSLog(@"[MobileUtils_APN] Swizzled method %@ in class %@", NSStringFromSelector(originalSelector), NSStringFromClass(appDelegateClass));
    }
}

#pragma mark - Swizzled Notification Methods

// Swizzled willPresentNotification
- (void)yy_userNotificationCenter:(UNUserNotificationCenter *)center
          willPresentNotification:(UNNotification *)notification
            withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {

    // Wrap the completionHandler with a run-once handler
    void (^onceHandler)(UNNotificationPresentationOptions) = RunOncePresentationCompletionHandler(completionHandler);

    // Call the original if available
    if ([self respondsToSelector:@selector(yy_userNotificationCenter:willPresentNotification:withCompletionHandler:)]) {
        // Here yy_ version is original due to method_exchangeImplementations logic
        [self yy_userNotificationCenter:center willPresentNotification:notification withCompletionHandler:onceHandler];
    }

    // Insert your logic here
    NSLog(@"LocalNotifications: willPresentNotification");

    UNNotificationTrigger *trigger = notification.request.trigger;

    // This is a remote notification? Ignore...
    if ([trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        return;
    }

    [LocalNotifications handleLocalNotification:notification];

    onceHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionBadge);
}

// Swizzled didReceiveNotificationResponse
- (void)yy_userNotificationCenter:(UNUserNotificationCenter *)center
     didReceiveNotificationResponse:(UNNotificationResponse *)response
              withCompletionHandler:(void (^)(void))completionHandler {

    // Wrap the completionHandler with a run-once handler
    void (^onceHandler)(void) = RunOnceVoidCompletionHandler(completionHandler);

    // Call the original if available
    if ([self respondsToSelector:@selector(yy_userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]) {
        [self yy_userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:onceHandler];
    }

    // Insert your logic here
    NSLog(@"LocalNotifications: didReceiveNotificationResponse");

    UNNotification *notification = response.notification;
    UNNotificationTrigger *trigger = notification.request.trigger;

    // This is a remote notification? Ignore...
    if ([trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        return;
    }

    [LocalNotifications handleLocalNotification:notification];

    onceHandler();
}


+ (NSString*) prefix
{
    return @"YYLocalNotification"; 
}

- (void) LocalPushNotification_Create:(NSString*)ID fire_time:(double)fire_time title:(NSString*)title message:(NSString*)message data:(NSString*)data {
    NSString *ID_withPrefix = [[LocalNotifications prefix] stringByAppendingString:ID];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = title;
    content.body = message;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"data_key" : data};

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:fire_time repeats:NO];

    NSArray *array = @[ID_withPrefix];
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:array];

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:ID_withPrefix content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
    {
        if (error)
            NSLog(@"Local Notification failed: %@", error.localizedDescription);
    }];
}

- (void) LocalPushNotification_Cancel:(NSString*)ID {
    ID = [[LocalNotifications prefix] stringByAppendingString:ID];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    NSArray *array = @[ID];
    [center removePendingNotificationRequestsWithIdentifiers:array];
}

- (void) LocalPushNotification_iOS_Permission_Request {
    if (@available(iOS 10.0, *)) {
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error)
         {
            NSMutableDictionary *data = [NSMutableDictionary dictionary];
            data[@"value"] = @(granted);
            data[@"success"] = @(error != nil);
            [LocalNotifications sendAsyncEvent:EVENT_OTHER_SOCIAL eventType:@"LocalPushNotification_iOS_Permission_Request" data:data];
         }];
    } else {
        // iOS 9 and earlier
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        data[@"value"] = @(YES);
        data[@"success"] = @(YES);
        [LocalNotifications sendAsyncEvent:EVENT_OTHER_SOCIAL eventType:@"LocalPushNotification_iOS_Permission_Request" data:data];
#pragma clang diagnostic pop
    }
}

- (void) LocalPushNotification_iOS_Permission_Status {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings)
    {
        NSString *statusString = @"Unknown";
        switch (settings.authorizationStatus) 
        {
            case UNAuthorizationStatusAuthorized:
                statusString = @"Authorized";
                break;
            case UNAuthorizationStatusDenied:
                statusString = @"Denied";
                break;
            case UNAuthorizationStatusNotDetermined:
                statusString = @"NotDetermined";
                break;
            case UNAuthorizationStatusProvisional:
                statusString = @"Provisional";
                break;
            case UNAuthorizationStatusEphemeral:
                statusString = @"Ephemeral";
                break;
            default:
                break;
        }

        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        data[@"value"] = statusString;
        data[@"success"] = @(YES);
        [LocalNotifications sendAsyncEvent:EVENT_OTHER_SOCIAL eventType:@"LocalPushNotification_iOS_Permission_Status" data:data];
    }];
}

#pragma mark - Helper Methods

+ (void)handleLocalNotification:(UNNotification*)notification {

    NSString *identifier = notification.request.identifier;

    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    data[@"id"] = [identifier substringFromIndex: [[LocalNotifications prefix]length]];
    data[@"title"] = notification.request.content.title;
    data[@"message"] = notification.request.content.body;
    data[@"data"] = notification.request.content.userInfo[@"data_key"];
    
    [LocalNotifications sendAsyncEvent:EVENT_OTHER_NOTIFICATION eventType:@"Notification_Local" data:data];
}

+ (void)sendAsyncEvent:(int)eventId eventType:(NSString *)eventType data:(NSDictionary *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        int dsMapIndex = dsMapCreate();
        dsMapAddString(dsMapIndex, (char *)"type", (char *)[eventType UTF8String]);

        for (NSString *key in data) {
            id value = data[key];
            const char *cKey = [key UTF8String];

            // Check if value is NSDictionary or NSArray and serialize to JSON string
            if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]]) {
                NSError *error = nil;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:value
                                                                   options:0 // NSJSONWritingPrettyPrinted can be used if formatting is desired
                                                                     error:&error];
                NSString *jsonString;
                if (error == nil && jsonData) {
                    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                } else {
                    NSLog(@"FirebaseUtils: JSON serialization failed for key '%@' with error: %@", key, error.localizedDescription);
                    jsonString = [value isKindOfClass:[NSDictionary class]] ? @"{}" : @"[]"; // Default to empty JSON container on failure
                }
                dsMapAddString(dsMapIndex, (char *)cKey, (char *)[jsonString UTF8String]);
            } else if ([value isKindOfClass:[NSString class]]) {
                dsMapAddString(dsMapIndex, (char *)cKey, (char *)[value UTF8String]);
            } else if ([value isKindOfClass:[NSNumber class]]) {
                NSNumber *numberValue = (NSNumber *)value;
                const char *type = [numberValue objCType];

                // Handle BOOL
                if (strcmp(type, @encode(BOOL)) == 0 || strcmp(type, @encode(bool)) == 0 || strcmp(type, @encode(char)) == 0) {
                    int boolValue = [numberValue boolValue] ? 1 : 0;
                    dsMapAddInt(dsMapIndex, (char *)cKey, boolValue);
                }
                // Handle integer types within int range
                else if (strcmp(type, @encode(int)) == 0 ||
                         strcmp(type, @encode(short)) == 0 ||
                         strcmp(type, @encode(unsigned int)) == 0 ||
                         strcmp(type, @encode(unsigned short)) == 0) {

                    int intValue = [numberValue intValue];
                    dsMapAddInt(dsMapIndex, (char *)cKey, intValue);
                }
                // Handle floating-point numbers
                else if (strcmp(type, @encode(float)) == 0 ||
                         strcmp(type, @encode(double)) == 0) {

                    double doubleValue = [numberValue doubleValue];
                    dsMapAddDouble(dsMapIndex, (char *)cKey, doubleValue);
                }
                // Handle signed long and long long
                else if (strcmp(type, @encode(long)) == 0 ||
                         strcmp(type, @encode(long long)) == 0) {

                    long long longValue = [numberValue longLongValue];
                    if (longValue >= INT_MIN && longValue <= INT_MAX) {
                        dsMapAddInt(dsMapIndex, (char *)cKey, (int)longValue);
                    } else if (llabs(longValue) <= (1LL << 53)) {
                        dsMapAddDouble(dsMapIndex, (char *)cKey, (double)longValue);
                    } else {
                        // Represent as special string format
                        NSString *formattedString = [NSString stringWithFormat:@"@i64@%llx$i64$", longValue];
                        dsMapAddString(dsMapIndex, (char *)cKey, (char *)[formattedString UTF8String]);
                    }
                }
                // Handle unsigned long and unsigned long long
                else if (strcmp(type, @encode(unsigned long)) == 0 ||
                         strcmp(type, @encode(unsigned long long)) == 0) {

                    unsigned long long ulongValue = [numberValue unsignedLongLongValue];
                    if (ulongValue <= (unsigned long long)INT_MAX) {
                        dsMapAddInt(dsMapIndex, (char *)cKey, (int)ulongValue);
                    } else if (ulongValue <= (1ULL << 53)) {
                        dsMapAddDouble(dsMapIndex, (char *)cKey, (double)ulongValue);
                    } else {
                        // Represent as special string format
                        NSString *formattedString = [NSString stringWithFormat:@"@i64@%llx$i64$", ulongValue];
                        dsMapAddString(dsMapIndex, (char *)cKey, (char *)[formattedString UTF8String]);
                    }
                } else {
                    // For other numeric types, default to adding as double
                    double doubleValue = [numberValue doubleValue];
                    dsMapAddDouble(dsMapIndex, (char *)cKey, doubleValue);
                }
            } else {
                // For other types, convert to string
                NSString *stringValue = [value description];
                dsMapAddString(dsMapIndex, (char *)cKey, (char *)[stringValue UTF8String]);
            }
        }
        CreateAsynEventWithDSMap(dsMapIndex, eventId);
    });
}

@end
