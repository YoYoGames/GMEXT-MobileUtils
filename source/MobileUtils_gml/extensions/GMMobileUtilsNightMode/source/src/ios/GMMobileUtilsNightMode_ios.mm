#import <UIKit/UIKit.h>

#import "GMMobileUtilsNightMode_ios.h"

extern UIViewController *g_controller;

@implementation GMMobileUtilsNightMode

- (double)mobile_utils_night_mode_check
{
    if (@available(iOS 12.0, *))
    {
        if (g_controller == nil)
            return 2.0;

        UIUserInterfaceStyle style =
            g_controller.traitCollection.userInterfaceStyle;

        if (style == UIUserInterfaceStyleDark)
            return 0.0;

        if (style == UIUserInterfaceStyleLight)
            return 1.0;
    }

    return 2.0;
}

@end
