
#import <Foundation/Foundation.h>
#import "MobileUtils_App_Popup_Settings_Ext.h"

const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);
extern UIViewController *g_controller;
extern UIView *g_glView;
extern int g_DeviceWidth;
extern int g_DeviceHeight;
	
	
@implementation MobileUtils_App_Popup_Settings_Ext
{}

-(void) MobileUtils_AppPopupSettings_Show 
{
    NSURL *url = [[NSURL alloc] initWithString:UIApplicationOpenSettingsURLString];
    // Ask the system to open that URL.
    [[UIApplication sharedApplication] openURL:url
                                    options:@{}
                            completionHandler:nil];
}

@end
