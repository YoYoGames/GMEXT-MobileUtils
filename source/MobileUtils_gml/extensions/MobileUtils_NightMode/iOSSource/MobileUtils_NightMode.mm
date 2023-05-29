
#import <Foundation/Foundation.h>
#import "MobileUtils_NightMode.h"

const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);
extern UIViewController *g_controller;
extern UIView *g_glView;
extern int g_DeviceWidth;
extern int g_DeviceHeight;
	
	
@implementation MobileUtils_NightMode
{
}

-(double) MobileUtils_NightMode_Check
{
	if (@available(iOS 12.0, *)) {

		if( g_controller.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ){
		   return 0.0;//is night
		}else{
			return 1.0;//is light
		}
	}
	else
		return 2.0;
}


@end
