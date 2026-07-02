#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>

#import "GMMobileUtilsGallery_ios.h"

extern UIViewController *g_controller;

/**
 * Extension Generator conversion of MobileUtils_Gallery.
 *
 * Callback:
 *     callback(success, path, filename, error)
 */
@implementation GMMobileUtilsGallery
{
    gm::wire::GMFunction _galleryCallback;
    BOOL _galleryRequestActive;
}

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        _galleryCallback = nil;
        _galleryRequestActive = NO;
    }

    return self;
}

- (void)mobile_utils_gallery_open:
    (gm::wire::GMFunction)callback
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_galleryRequestActive)
        {
            callback.call(
                false,
                "",
                "",
                "A gallery request is already active."
            );
            return;
        }

        if (g_controller == nil)
        {
            callback.call(
                false,
                "",
                "",
                "Root view controller is unavailable."
            );
            return;
        }

        if (![UIImagePickerController
                isSourceTypeAvailable:
                    UIImagePickerControllerSourceTypePhotoLibrary])
        {
            callback.call(
                false,
                "",
                "",
                "Photo library is unavailable on this device."
            );
            return;
        }

        if (g_controller.presentedViewController != nil)
        {
            callback.call(
                false,
                "",
                "",
                "Another screen is already presented."
            );
            return;
        }

        _galleryCallback = callback;
        _galleryRequestActive = YES;

        UIImagePickerController *picker =
            [[UIImagePickerController alloc] init];

        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType =
            UIImagePickerControllerSourceTypePhotoLibrary;

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
        info[UIImagePickerControllerOriginalImage];

    [picker dismissViewControllerAnimated:YES completion:nil];

    if (image == nil)
    {
        [self finishGalleryRequest:
            false
            path:""
            filename:""
            error:"Gallery returned no image."];
        return;
    }

    NSString *fileName = nil;

    if (@available(iOS 11.0, *))
    {
        NSURL *imageURL =
            info[UIImagePickerControllerImageURL];

        if (imageURL != nil)
        {
            NSString *baseName =
                [[imageURL lastPathComponent]
                    stringByDeletingPathExtension];

            fileName =
                [baseName stringByAppendingPathExtension:@"jpg"];
        }
    }

    if (fileName.length == 0)
    {
        fileName = [NSString stringWithFormat:
            @"image_%.0f.jpg",
            [[NSDate date] timeIntervalSince1970] * 1000.0];
    }

    NSString *documentsPath =
        [NSSearchPathForDirectoriesInDomains(
            NSDocumentDirectory,
            NSUserDomainMask,
            YES
        ) firstObject];

    NSString *path =
        [documentsPath
            stringByAppendingPathComponent:fileName];

    // Decode/re-encode + write off the main thread — a large photo would
    // otherwise block the UI. Deliver the callback back on the main thread.
    dispatch_async(
        dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0),
        ^{
            NSData *jpegData =
                UIImageJPEGRepresentation(image, 1.0);

            BOOL written = NO;
            if (jpegData != nil)
                written = [jpegData writeToFile:path
                                        options:NSDataWritingAtomic
                                          error:nil];

            dispatch_async(dispatch_get_main_queue(), ^{
                if (jpegData == nil)
                {
                    [self finishGalleryRequest:
                        false
                        path:""
                        filename:""
                        error:"Could not encode selected image."];
                    return;
                }

                if (!written)
                {
                    [self finishGalleryRequest:
                        false
                        path:""
                        filename:""
                        error:"Could not save selected image."];
                    return;
                }

                [self finishGalleryRequest:
                    true
                    path:(path.UTF8String ?: "")
                    filename:(fileName.UTF8String ?: "")
                    error:""];
            });
        }
    );
}

- (void)imagePickerControllerDidCancel:
    (UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self finishGalleryRequest:
            false
            path:""
            filename:""
            error:"Gallery selection was cancelled."];
    }];
}

- (void)finishGalleryRequest:
            (bool)success
                          path:
            (const char *)path
                      filename:
            (const char *)filename
                         error:
            (const char *)error
{
    gm::wire::GMFunction callback = _galleryCallback;

    _galleryCallback = nil;
    _galleryRequestActive = NO;

    if (callback)
        callback.call(success, path, filename, error);
}

@end
