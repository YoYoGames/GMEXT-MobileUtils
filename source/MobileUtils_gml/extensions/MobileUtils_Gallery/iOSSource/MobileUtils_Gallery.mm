
#import <Foundation/Foundation.h>
#import "MobileUtils_Gallery.h"

#import <Photos/Photos.h>

const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);
extern UIViewController *g_controller;
extern UIView *g_glView;
extern int g_DeviceWidth;
extern int g_DeviceHeight;
    

@implementation MobileUtils_Gallery
{
    Boolean PickGalery;
}


-(NSString*)iOS_GetPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return([paths objectAtIndex:0]);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];

    NSString *fileName = nil;

    // =========================
    // iOS 11+ BEST METHOD
    // =========================
    if (@available(iOS 11.0, *))
    {
        NSURL *url = info[UIImagePickerControllerImageURL];

        if (url)
        {
            NSString *originalName = [url lastPathComponent];

            NSString *baseName = [originalName stringByDeletingPathExtension];

            fileName = [baseName stringByAppendingPathExtension:@"jpg"];
        }
    }

    // =========================
    // FALLBACK (iOS 10 and older OR missing URL)
    // =========================
    if (fileName == nil)
    {
        fileName = [NSString stringWithFormat:@"image_%f.jpg",
                    [[NSDate date] timeIntervalSince1970]];
    }

    // Build path
    NSString *path =
        [[self iOS_GetPath] stringByAppendingPathComponent:fileName];

    // Save as JPEG (your design choice)
    [UIImageJPEGRepresentation(chosenImage, 1.0)
        writeToFile:path
        atomically:YES];

    [picker dismissViewControllerAnimated:YES completion:nil];

    if (PickGalery)
    {
        int dsMapIndex = CreateDsMap(
            3,
            "type", 0.0, "MobileUtils_Gallery_Open",
            "path", 0.0, [path UTF8String],
            "filename", 0.0, [fileName UTF8String]
        );

        CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
    }
}

-(void) MobileUtils_Gallery_Open
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [g_controller presentViewController:picker animated:YES completion:NULL];
    PickGalery = true;
}


@end
