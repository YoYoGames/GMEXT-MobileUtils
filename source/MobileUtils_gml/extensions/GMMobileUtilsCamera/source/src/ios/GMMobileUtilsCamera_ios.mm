#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GMMobileUtilsCamera_ios.h"

extern UIViewController *g_controller;

/**
 * Extension Generator conversion of MobileUtils_Camera.
 *
 * Callback:
 *     callback(success, path, error)
 */
@implementation GMMobileUtilsCamera
{
    gm::wire::GMFunction _cameraCallback;
    BOOL _cameraRequestActive;
}

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        _cameraCallback = nil;
        _cameraRequestActive = NO;
    }

    return self;
}

- (void)mobile_utils_camera_open:
    (gm::wire::GMFunction)callback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_cameraRequestActive)
        {
            callback.call(
                false,
                "",
                "A camera request is already active."
            );
            return;
        }

        if (g_controller == nil)
        {
            callback.call(
                false,
                "",
                "Root view controller is unavailable."
            );
            return;
        }

        if (![UIImagePickerController
                isSourceTypeAvailable:
                    UIImagePickerControllerSourceTypeCamera])
        {
            callback.call(
                false,
                "",
                "Camera is unavailable on this device."
            );
            return;
        }

        if (g_controller.presentedViewController != nil)
        {
            callback.call(
                false,
                "",
                "Another screen is already presented."
            );
            return;
        }

        _cameraCallback = callback;
        _cameraRequestActive = YES;

        UIImagePickerController *picker =
            [[UIImagePickerController alloc] init];

        picker.delegate = self;
        // NO for parity with Android/Gallery (no forced crop step).
        picker.allowsEditing = NO;
        picker.sourceType =
            UIImagePickerControllerSourceTypeCamera;

        [g_controller
            presentViewController:picker
            animated:YES
            completion:nil];
    });
}

- (void)imagePickerController:
            (UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:
            (NSDictionary<UIImagePickerControllerInfoKey, id> *)info
{
    UIImage *image =
        info[UIImagePickerControllerEditedImage];

    if (image == nil)
        image = info[UIImagePickerControllerOriginalImage];

    [picker dismissViewControllerAnimated:YES completion:nil];

    if (image == nil)
    {
        [self finishCameraRequest:
            false
            path:""
            error:"Camera returned no image."];
        return;
    }

    NSString *documentsPath =
        [NSSearchPathForDirectoriesInDomains(
            NSDocumentDirectory,
            NSUserDomainMask,
            YES
        ) firstObject];

    NSString *path =
        [documentsPath
            stringByAppendingPathComponent:@"temp.jpg"];

    // Encode + write off the main thread — a full-resolution capture would
    // otherwise block the UI long enough to risk the watchdog. Fire the
    // callback back on the main thread for consistency with every other path.
    dispatch_async(
        dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0),
        ^{
            NSData *jpegData =
                UIImageJPEGRepresentation(image, 0.85);

            BOOL written = NO;
            if (jpegData != nil)
                written = [jpegData writeToFile:path
                                        options:NSDataWritingAtomic
                                          error:nil];

            dispatch_async(dispatch_get_main_queue(), ^{
                if (jpegData == nil)
                {
                    [self finishCameraRequest:
                        false
                        path:""
                        error:"Could not encode camera image."];
                    return;
                }

                if (!written)
                {
                    [self finishCameraRequest:
                        false
                        path:""
                        error:"Could not save camera image."];
                    return;
                }

                [self finishCameraRequest:
                    true
                    path:(path.UTF8String ?: "")
                    error:""];
            });
        }
    );
}

- (void)imagePickerControllerDidCancel:
    (UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self finishCameraRequest:
            false
            path:""
            error:"Camera capture was cancelled."];
    }];
}

- (void)finishCameraRequest:
            (bool)success
                         path:
            (const char *)path
                        error:
            (const char *)error
{
    gm::wire::GMFunction callback = _cameraCallback;

    _cameraCallback = nil;
    _cameraRequestActive = NO;

    if (callback)
        callback.call(success, path, error);
}

@end
