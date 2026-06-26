
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GMMobileUtilsAppPopupSettings_ios.h"

/**
 * Extension Generator conversion of MobileUtils_App_Popup_Settings_Ext.
 *
 * Callback:
 *     callback(success, error)
 *
 * Success means iOS accepted the request to open this application's Settings
 * page.
 */
@implementation GMMobileUtilsAppPopupSettings

- (void)mobile_utils_app_popup_settings_show:
    (gm::wire::GMFunction)callback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url =
            [NSURL URLWithString:UIApplicationOpenSettingsURLString];

        if (url == nil)
        {
            callback.call(
                false,
                "Could not create the application settings URL."
            );
            return;
        }

        UIApplication *application =
            [UIApplication sharedApplication];

        if (![application canOpenURL:url])
        {
            callback.call(
                false,
                "The application settings URL cannot be opened."
            );
            return;
        }

        [application
            openURL:url
            options:@{}
            completionHandler:^(BOOL success)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success)
                {
                    callback.call(true, "");
                }
                else
                {
                    callback.call(
                        false,
                        "iOS could not open the application settings page."
                    );
                }
            });
        }];
    });
}

@end
