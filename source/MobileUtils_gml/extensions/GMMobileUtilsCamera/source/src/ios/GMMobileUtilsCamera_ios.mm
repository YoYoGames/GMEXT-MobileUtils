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

        _cameraCallback = callback;
        _cameraRequestActive = YES;

        UIImagePickerController *picker =
            [[UIImagePickerController alloc] init];

        picker.delegate = self;
        picker.allowsEditing = YES;
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

    if (image == nil)
    {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self finishCameraRequest:
                false
                path:""
                error:"Camera returned no image."];
        }];
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

    NSData *jpegData =
        UIImageJPEGRepresentation(image, 1.0);

    if (jpegData == nil)
    {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self finishCameraRequest:
                false
                path:""
                error:"Could not encode camera image."];
        }];
        return;
    }

    NSError *writeError = nil;
    BOOL written =
        [jpegData writeToFile:path
                      options:NSDataWritingAtomic
                        error:&writeError];

    [picker dismissViewControllerAnimated:YES completion:^{
        if (!written)
        {
            const char *message =
                writeError.localizedDescription.UTF8String;

            [self finishCameraRequest:
                false
                path:""
                error:(message ?: "Could not save camera image.")];
            return;
        }

        [self finishCameraRequest:
            true
            path:(path.UTF8String ?: "")
            error:""];
    }];
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
