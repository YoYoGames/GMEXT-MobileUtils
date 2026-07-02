#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <objc/runtime.h>

#import "GMMobileUtilsAPN_ios.h"

/**
 * Extension Generator conversion of MobileUtils_APN.
 *
 * Registration callback:
 *     callback(success, token, error)
 *
 * Success means that Apple returned an APNs device token.
 */
@implementation GMMobileUtilsAPN

static NSString *g_cachedDeviceToken = nil;
static gm::wire::GMFunction g_registerCallback = nil;
static BOOL g_registrationActive = NO;

// Bumped on every register call so a stale timeout can tell whether it still
// applies to the in-flight request.
static NSUInteger g_registrationGeneration = 0;

// How long to wait for the OS to deliver didRegister / didFail before failing
// the callback so the request cannot lock out every later call forever.
static const NSTimeInterval kAPNRegistrationTimeout = 30.0;

#pragma mark - App delegate swizzling

+ (void)load
{
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        [self swizzleAppDelegateMethods];
    });
}

+ (void)swizzleAppDelegateMethods
{
    Class appDelegateClass = NSClassFromString(@"iPad_RunnerAppDelegate");

    if (appDelegateClass == Nil)
    {
        NSLog(
            @"[GMMobileUtilsAPN] Could not find iPad_RunnerAppDelegate."
        );
        return;
    }

    [self
        swizzleMethodInClass:appDelegateClass
        originalSelector:
            @selector(
                application:
                didRegisterForRemoteNotificationsWithDeviceToken:
            )
        swizzledSelector:
            @selector(
                apn_application:
                didRegisterForRemoteNotificationsWithDeviceToken:
            )
    ];

    [self
        swizzleMethodInClass:appDelegateClass
        originalSelector:
            @selector(
                application:
                didFailToRegisterForRemoteNotificationsWithError:
            )
        swizzledSelector:
            @selector(
                apn_application:
                didFailToRegisterForRemoteNotificationsWithError:
            )
    ];
}

+ (void)swizzleMethodInClass:(Class)targetClass
           originalSelector:(SEL)originalSelector
           swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod =
        class_getInstanceMethod(targetClass, originalSelector);

    Method swizzledMethod =
        class_getInstanceMethod(self, swizzledSelector);

    if (swizzledMethod == NULL)
    {
        NSLog(
            @"[GMMobileUtilsAPN] Missing swizzled method %@.",
            NSStringFromSelector(swizzledSelector)
        );
        return;
    }

    BOOL added =
        class_addMethod(
            targetClass,
            originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        );

    if (added)
    {
        return;
    }

    if (originalMethod == NULL)
    {
        NSLog(
            @"[GMMobileUtilsAPN] Could not find original method %@.",
            NSStringFromSelector(originalSelector)
        );
        return;
    }

    Method installedMethod =
        class_getInstanceMethod(targetClass, originalSelector);

    // Install OUR implementation under the swizzled selector, then exchange, so
    // afterwards the original selector runs our handler and the swizzled selector
    // chains to the runner's previous implementation. (Adding the installed IMP
    // here instead would leave both selectors pointing at the runner's IMP and
    // our handler would never run.)
    class_addMethod(
        targetClass,
        swizzledSelector,
        method_getImplementation(swizzledMethod),
        method_getTypeEncoding(swizzledMethod)
    );

    Method replacementMethod =
        class_getInstanceMethod(targetClass, swizzledSelector);

    method_exchangeImplementations(
        installedMethod,
        replacementMethod
    );
}

#pragma mark - Swizzled callbacks

- (void)apn_application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:
        (NSData *)deviceToken
{
    /*
     * After method exchange, this selector points to the original runner
     * implementation. When the runner had no implementation, this selector
     * does not exist and should not be called.
     */
    if ([self respondsToSelector:
            @selector(
                apn_application:
                didRegisterForRemoteNotificationsWithDeviceToken:
            )])
    {
        [self
            apn_application:application
            didRegisterForRemoteNotificationsWithDeviceToken:
                deviceToken
        ];
    }

    NSString *token =
        [GMMobileUtilsAPN stringFromDeviceToken:deviceToken];

    g_cachedDeviceToken = [token copy];

    dispatch_async(dispatch_get_main_queue(), ^{
        [GMMobileUtilsAPN
            finishRegistration:true
            token:(token.UTF8String ?: "")
            error:""
        ];
    });
}

- (void)apn_application:(UIApplication *)application
    didFailToRegisterForRemoteNotificationsWithError:
        (NSError *)error
{
    if ([self respondsToSelector:
            @selector(
                apn_application:
                didFailToRegisterForRemoteNotificationsWithError:
            )])
    {
        [self
            apn_application:application
            didFailToRegisterForRemoteNotificationsWithError:
                error
        ];
    }

    NSString *message =
        error.localizedDescription
            ?: @"APNs registration failed.";

    dispatch_async(dispatch_get_main_queue(), ^{
        [GMMobileUtilsAPN
            finishRegistration:false
            token:""
            error:(message.UTF8String ?: "APNs registration failed.")
        ];
    });
}

#pragma mark - Generator API

- (void)mobile_utils_apn_register:
    (gm::wire::GMFunction)callback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (g_registrationActive)
        {
            callback.call(
                false,
                "",
                "An APNs registration request is already active."
            );
            return;
        }

        /*
         * Return the cached token immediately when registration has already
         * completed during this process.
         */
        if (g_cachedDeviceToken.length > 0)
        {
            callback.call(
                true,
                g_cachedDeviceToken.UTF8String ?: "",
                ""
            );
            return;
        }

        g_registerCallback = callback;
        g_registrationActive = YES;

        NSUInteger generation = ++g_registrationGeneration;

        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                (int64_t)(kAPNRegistrationTimeout * NSEC_PER_SEC)
            ),
            dispatch_get_main_queue(),
            ^{
                if (g_registrationActive &&
                    generation == g_registrationGeneration)
                {
                    [GMMobileUtilsAPN
                        finishRegistration:false
                        token:""
                        error:"APNs registration timed out."
                    ];
                }
            }
        );

        if (@available(iOS 10.0, *))
        {
            UNUserNotificationCenter *center =
                [UNUserNotificationCenter currentNotificationCenter];

            [center
                requestAuthorizationWithOptions:
                    (
                        UNAuthorizationOptionAlert
                        | UNAuthorizationOptionSound
                        | UNAuthorizationOptionBadge
                    )
                completionHandler:
                    ^(BOOL granted, NSError *_Nullable error)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!granted)
                    {
                        NSString *message =
                            error.localizedDescription
                                ?: @"Notification permission was denied.";

                        [GMMobileUtilsAPN
                            finishRegistration:false
                            token:""
                            error:
                                (
                                    message.UTF8String
                                        ?: "Notification permission was denied."
                                )
                        ];
                        return;
                    }

                    [[UIApplication sharedApplication]
                        registerForRemoteNotifications];
                });
            }];

            return;
        }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIUserNotificationSettings *settings =
            [UIUserNotificationSettings
                settingsForTypes:
                    (
                        UIUserNotificationTypeSound
                        | UIUserNotificationTypeAlert
                        | UIUserNotificationTypeBadge
                    )
                categories:nil
            ];

        [[UIApplication sharedApplication]
            registerUserNotificationSettings:settings];

        [[UIApplication sharedApplication]
            registerForRemoteNotifications];
#pragma clang diagnostic pop
    });
}

- (std::string)mobile_utils_apn_get_token
{
    if (g_cachedDeviceToken.length == 0)
        return std::string();

    return std::string(
        g_cachedDeviceToken.UTF8String ?: ""
    );
}

#pragma mark - Utilities

+ (void)finishRegistration:(bool)success
                     token:(const char *)token
                     error:(const char *)error
{
    gm::wire::GMFunction callback = g_registerCallback;

    g_registerCallback = nil;
    g_registrationActive = NO;

    if (callback)
        callback.call(success, token, error);
}

+ (NSString *)stringFromDeviceToken:(NSData *)deviceToken
{
    const unsigned char *bytes =
        (const unsigned char *)deviceToken.bytes;

    if (bytes == NULL)
        return @"";

    NSMutableString *token =
        [NSMutableString
            stringWithCapacity:deviceToken.length * 2];

    for (NSUInteger index = 0;
         index < deviceToken.length;
         ++index)
    {
        [token appendFormat:@"%02x", bytes[index]];
    }

    return [token copy];
}

@end
