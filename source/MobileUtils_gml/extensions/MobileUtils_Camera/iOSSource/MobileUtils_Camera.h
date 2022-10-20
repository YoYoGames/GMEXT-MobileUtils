
#import <UIKit/UIKit.h>


@interface MobileUtils_Camera : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
   
}

@property (nonatomic, retain) NSString* ImagePath;

-(NSString*)iOS_GetPath;

@end
