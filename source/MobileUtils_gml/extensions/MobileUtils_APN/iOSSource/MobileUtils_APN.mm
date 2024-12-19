#import "MobileUtils_APN.h"

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

const int EVENT_OTHER_NOTIFICATION = 71;

extern "C" int dsMapCreate();
extern "C" void dsMapAddInt(int _dsMap, char* _key, int _value);
extern "C" void dsMapAddDouble(int _dsMap, char* _key, double _value);
extern "C" void dsMapAddString(int _dsMap, char* _key, char* _value);
extern "C" void createSocialAsyncEventWithDSMap(int dsmapindex);
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);

@interface MobileUtils_APN ()

@property (class, nonatomic, strong) NSString *cachedDeviceToken;

@end

@implementation MobileUtils_APN

static NSString *_cachedDeviceToken = nil;

+ (NSString *)cachedDeviceToken {
    return _cachedDeviceToken;
}

+ (void)setCachedDeviceToken:(NSString *)deviceToken {
    _cachedDeviceToken = [deviceToken copy];
}

#pragma mark - Perform Swizzling

// This will be called at load time (when source is loaded so it's the ideal place to do the swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleAppDelegateMethods];
    });
}

+ (void)swizzleAppDelegateMethods {
    Class appDelegateClass = [iPad_RunnerAppDelegate class];

    [self swizzleMethodInClass:appDelegateClass
              originalSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)
              swizzledSelector:@selector(apn_application:didRegisterForRemoteNotificationsWithDeviceToken:)];

    [self swizzleMethodInClass:appDelegateClass
              originalSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)
              swizzledSelector:@selector(apn_application:didFailToRegisterForRemoteNotificationsWithError:)];
}

+ (void)swizzleMethodInClass:(Class)appDelegateClass
            originalSelector:(SEL)originalSelector
            swizzledSelector:(SEL)swizzledSelector {

    Method originalMethod = class_getInstanceMethod(appDelegateClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);

    // Try to add the swizzled method to the class under the original selector
    BOOL didAddMethod = class_addMethod(appDelegateClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        // The original method didn't exist, so we added our swizzled method under the original selector
        NSLog(@"[MobileUtils_APN] Added method %@ to class %@", NSStringFromSelector(originalSelector), NSStringFromClass(appDelegateClass));
    } else {
        // The original method exists, so we exchange implementations
        method_exchangeImplementations(originalMethod, swizzledMethod);
        NSLog(@"[MobileUtils_APN] Swizzled method %@ in class %@", NSStringFromSelector(originalSelector), NSStringFromClass(appDelegateClass));
    }
}

#pragma mark - Swizzled Methods

// This method will replace the original didRegisterForRemoteNotificationsWithDeviceToken:
- (void)apn_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Call the original method (which is now apn_application:didRegisterForRemoteNotificationsWithDeviceToken:)
    if ([self respondsToSelector:@selector(apn_application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
        [self apn_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }

    NSString *deviceTokenString = [MobileUtils_APN stringFromDeviceToken:deviceToken];

    // Cache the token
    [MobileUtils_APN setCachedDeviceToken:deviceTokenString];

    // Send event to game engine
    dispatch_async(dispatch_get_main_queue(), ^{
        int dsMapIndex = dsMapCreate();
        dsMapAddString(dsMapIndex, (char *)"type", (char *)"MobileUtils_APN_Register");
        dsMapAddString(dsMapIndex, (char *)"token", (char *)[deviceTokenString UTF8String]);
        dsMapAddInt(dsMapIndex, (char *)"success", 1);
        CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_NOTIFICATION);
    });
}

// This method will replace the original didFailToRegisterForRemoteNotificationsWithError:
- (void)apn_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // Call the original method (which is now apn_application:didFailToRegisterForRemoteNotificationsWithError:)
    if ([self respondsToSelector:@selector(apn_application:didFailToRegisterForRemoteNotificationsWithError:)]) {
        [self apn_application:application didFailToRegisterForRemoteNotificationsWithError:error];
    }

    NSLog(@"[MobileUtils_APN] didFailToRegisterForRemoteNotificationsWithError called. Error: %@", error.localizedDescription);

    // Send event to game engine
    dispatch_async(dispatch_get_main_queue(), ^{
        int dsMapIndex = dsMapCreate();
        dsMapAddString(dsMapIndex, (char *)"type", (char *)"MobileUtils_APN_Register");
        dsMapAddString(dsMapIndex, (char *)"errorMessage", (char *)[error.localizedDescription UTF8String]);
        dsMapAddInt(dsMapIndex, (char *)"success", 0);
        CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_NOTIFICATION);
    });
}

#pragma mark - Extension Methods

- (instancetype)init {
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (@available(iOS 10.0, *)) {
                // iOS 10 and later
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                
                [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge)
                                      completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[UIApplication sharedApplication] registerForRemoteNotifications];
                        });
                    } else {
                        NSLog(@"User denied notification permissions: %@", error);
                    }
                }];
            } else {
                // iOS 9 and earlier
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
                [[UIApplication sharedApplication] registerForRemoteNotifications];
#pragma clang diagnostic pop
            }
        });
    }
    return self;
}

- (NSString *)MobileUtils_APN_Get_Token {
    NSString *token = [MobileUtils_APN cachedDeviceToken];
    if (token) {
        return token;
    } else {
        return @""; // Return empty string if token is nil
    }
}

#pragma mark - Utility Methods

+ (NSString *)stringFromDeviceToken:(NSData *)deviceToken {
    const unsigned char *dataBuffer = (const unsigned char *)[deviceToken bytes];

    if (!dataBuffer) {
        return [NSString string];
    }

    NSUInteger dataLength = [deviceToken length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];

    for (NSUInteger i = 0; i < dataLength; ++i) {
        [hexString appendFormat:@"%02x", dataBuffer[i]];
    }

    return [hexString copy];
}

@end