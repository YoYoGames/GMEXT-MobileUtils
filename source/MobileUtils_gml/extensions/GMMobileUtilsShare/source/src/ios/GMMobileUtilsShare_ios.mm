
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GMMobileUtilsShare_ios.h"

extern UIViewController *g_controller;

/**
 * Extension Generator conversion of MobileUtils_Share.
 *
 * Callback:
 *     callback(success, error)
 *
 * Success means that iOS successfully presented the share sheet.
 * It does not mean that the user completed a share action.
 */
@implementation GMMobileUtilsShare

- (void)mobile_utils_share_open:(std::string_view)title
                          mime:(std::string_view)mime
                         value:(std::string_view)value
                      callback:(gm::wire::GMFunction)callback
{
    NSString *titleString =
        [[NSString alloc] initWithBytes:title.data()
                                length:title.size()
                              encoding:NSUTF8StringEncoding];

    NSString *mimeString =
        [[NSString alloc] initWithBytes:mime.data()
                                length:mime.size()
                              encoding:NSUTF8StringEncoding];

    NSString *valueString =
        [[NSString alloc] initWithBytes:value.data()
                                length:value.size()
                              encoding:NSUTF8StringEncoding];

    dispatch_async(dispatch_get_main_queue(), ^{
        if (g_controller == nil)
        {
            callback.call(false, "Root view controller is unavailable.");
            return;
        }

        NSMutableArray *items = [NSMutableArray array];

        if ([self isTextMimeType:mimeString])
        {
            [items addObject:valueString ?: @""];
        }
        else
        {
            NSString *documentsPath =
                [NSSearchPathForDirectoriesInDomains(
                    NSDocumentDirectory,
                    NSUserDomainMask,
                    YES
                ) firstObject];

            NSString *filePath =
                [documentsPath stringByAppendingPathComponent:
                    valueString ?: @""];

            if (![[NSFileManager defaultManager]
                    fileExistsAtPath:filePath])
            {
                std::string errorMessage =
                    "Source file does not exist: "
                    + std::string(filePath.UTF8String ?: "");

                callback.call(false, errorMessage);
                return;
            }

            NSURL *fileURL =
                [NSURL fileURLWithPath:filePath];

            if (fileURL == nil)
            {
                callback.call(false, "Could not create file URL.");
                return;
            }

            [items addObject:fileURL];

            if (titleString.length > 0)
                [items addObject:titleString];
        }

        UIActivityViewController *shareController =
            [[UIActivityViewController alloc]
                initWithActivityItems:items
                applicationActivities:nil];

        UIPopoverPresentationController *popover =
            shareController.popoverPresentationController;

        if (popover != nil)
        {
            popover.sourceView = g_controller.view;
            popover.sourceRect = CGRectMake(
                CGRectGetMidX(g_controller.view.bounds),
                CGRectGetMidY(g_controller.view.bounds),
                1.0,
                1.0
            );
        }

        [g_controller
            presentViewController:shareController
            animated:YES
            completion:^{
                callback.call(true, "");
            }];
    });
}

- (BOOL)isTextMimeType:(NSString *)mime
{
    return [mime isEqualToString:@"text/plain"]
        || [mime isEqualToString:@"text/rtf"]
        || [mime isEqualToString:@"text/html"]
        || [mime isEqualToString:@"text/json"]
        || [mime isEqualToString:@"application/json"];
}

@end
