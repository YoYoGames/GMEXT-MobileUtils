#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ios/GMMobileUtilsCameraInternal_ios.h"

@interface GMMobileUtilsCamera : GMMobileUtilsCameraInternal
<
    GMMobileUtilsCameraInterface,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@end