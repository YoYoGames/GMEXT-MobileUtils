#import <UIKit/UIKit.h>

#import "GMMobileUtilsImageTools_ios.h"

@implementation GMMobileUtilsImageTools

- (double)mobile_utils_image_width:
    (std::string_view)path
{
    NSString *pathString =
        [[NSString alloc]
            initWithBytes:path.data()
            length:path.size()
            encoding:NSUTF8StringEncoding];

    UIImage *image =
        [UIImage imageWithContentsOfFile:pathString];

    return image != nil ? image.size.width : -1.0;
}

- (double)mobile_utils_image_height:
    (std::string_view)path
{
    NSString *pathString =
        [[NSString alloc]
            initWithBytes:path.data()
            length:path.size()
            encoding:NSUTF8StringEncoding];

    UIImage *image =
        [UIImage imageWithContentsOfFile:pathString];

    return image != nil ? image.size.height : -1.0;
}

- (bool)mobile_utils_image_resize:
            (std::string_view)path
                              width:
            (double)width
                             height:
            (double)height
{
    if (width <= 0.0 || height <= 0.0)
        return false;

    NSString *pathString =
        [[NSString alloc]
            initWithBytes:path.data()
            length:path.size()
            encoding:NSUTF8StringEncoding];

    UIImage *image =
        [UIImage imageWithContentsOfFile:pathString];

    if (image == nil)
        return false;

    CGSize size = CGSizeMake(width, height);

    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, width, height)];

    UIImage *result =
        UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    if (result == nil)
        return false;

    NSData *pngData =
        UIImagePNGRepresentation(result);

    return pngData != nil &&
        [pngData writeToFile:pathString atomically:YES];
}

- (bool)mobile_utils_image_crop:
            (std::string_view)path
                            width:
            (double)width
                           height:
            (double)height
                         offset_x:
            (double)offsetX
                         offset_y:
            (double)offsetY
{
    NSString *pathString =
        [[NSString alloc]
            initWithBytes:path.data()
            length:path.size()
            encoding:NSUTF8StringEncoding];

    UIImage *image =
        [UIImage imageWithContentsOfFile:pathString];

    if (image == nil)
        return false;

    CGRect cropRect =
        CGRectMake(offsetX, offsetY, width, height);

    CGRect imageBounds =
        CGRectMake(
            0,
            0,
            image.size.width,
            image.size.height
        );

    if (width <= 0.0 ||
        height <= 0.0 ||
        offsetX < 0.0 ||
        offsetY < 0.0 ||
        !CGRectContainsRect(imageBounds, cropRect))
    {
        return false;
    }

    CGImageRef imageRef =
        CGImageCreateWithImageInRect(
            image.CGImage,
            cropRect
        );

    if (imageRef == nil)
        return false;

    UIImage *cropped =
        [UIImage imageWithCGImage:imageRef
                           scale:image.scale
                     orientation:image.imageOrientation];

    CGImageRelease(imageRef);

    NSData *pngData =
        UIImagePNGRepresentation(cropped);

    return pngData != nil &&
        [pngData writeToFile:pathString atomically:YES];
}

@end
