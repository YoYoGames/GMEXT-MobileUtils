
#import <Foundation/Foundation.h>
#import "MobileUtils_Camera.h"

const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);
extern UIViewController *g_controller;
extern UIView *g_glView;
extern int g_DeviceWidth;
extern int g_DeviceHeight;
	
	
@implementation MobileUtils_Camera
{
}

-(void) MobileUtils_Camera_Open
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [g_controller presentViewController:picker animated:YES completion:NULL];
}


-(NSString*)iOS_GetPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return([paths objectAtIndex:0]);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
    //UIImageWriteToSavedPhotosAlbum(chosenImage,nil,nil,nil);
	
    NSString* path = [[self iOS_GetPath] stringByAppendingString: @"/temp.jpg"];
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    [UIImageJPEGRepresentation(chosenImage, 1.0) writeToFile:path atomically:YES];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
	
	int dsMapIndex;
	dsMapIndex = CreateDsMap(2,"type",0.0 ,"MobileUtils_Camera_Open","path", 0.0,[path UTF8String]);
	CreateAsynEventWithDSMap(dsMapIndex,EVENT_OTHER_SOCIAL);
}


@end
