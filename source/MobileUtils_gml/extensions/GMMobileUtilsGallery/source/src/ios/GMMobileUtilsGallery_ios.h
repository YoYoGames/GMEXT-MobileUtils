#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ios/GMMobileUtilsGalleryInternal_ios.h"

@interface GMMobileUtilsGallery :
    GMMobileUtilsGalleryInternal
    <GMMobileUtilsGalleryInterface,
     UIImagePickerControllerDelegate,
     UINavigationControllerDelegate>
@end


