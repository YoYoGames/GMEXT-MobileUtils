//
//  Released by YoYo Games Ltd. on 17/04/2014. Intended for use with GM: S EA97 and above ONLY.
//  Copyright YoYo Games Ltd., 2014.
//  For support please submit a ticket at help.yoyogames.com
//
//


#import "TapticEngine.h"


const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);
extern UIViewController *g_controller;
extern UIView *g_glView;
extern int g_DeviceWidth;
extern int g_DeviceHeight;

@implementation TapticEngine

-(id)init {
    if ( self = [super init] ) {
        
        
        return self;
	}
}


/////////////////////////////////////////////////////TapticEngine

-(double) MobileUtils_TapticEngine_Is_Supported
{
    UIDevice* device = [ UIDevice currentDevice ];
    NSNumber* nr = [ device valueForKey:@"_feedbackSupportLevel" ];
    switch (nr.intValue) {
    case 2:
        // 2 means the device has a Taptic Engine
        // Put Taptic Engine code here, using the APIs explained above
        return 2;
    case 1:
    // 1 means no Taptic Engine, but will support AudioToolbox
    // AudioToolbox code from the myriad of other answers!
        return 1;
    default:
        // 0
        // No haptic support
        // Do something else, like a beeping noise or LED flash instead of haptics
        return 0;
    }
}


typedef enum {

	IMPACT_LIGHT=0,
	IMPACT_MEDIUM=1,
	IMPACT_HEAVY=2,
	IMPACT_RIGID=3,
	IMPACT_SOFT=4,
	
	SELECTION=10,
	
	NOTIFICATION_WARNING=20,
	NOTIFICATION_SUCCESS=21,
	NOTIFICATION_ERROR=22,
	
} yy_taptic_engine;

-(void) MobileUtils_TapticEngine_Vibrate:(double) kind
{
	if(kind <10)
    {
        UIImpactFeedbackGenerator *mUIImpactFeedbackGenerator = [[UIImpactFeedbackGenerator alloc] init];
        
        // (UIImpactFeedbackStyle)
        switch ((yy_taptic_engine) kind)
        {
                
            case IMPACT_LIGHT:
                [mUIImpactFeedbackGenerator initWithStyle:UIImpactFeedbackStyleLight];
                break;
                
            case IMPACT_MEDIUM:
                [mUIImpactFeedbackGenerator initWithStyle:UIImpactFeedbackStyleMedium];
                break;
                
            case IMPACT_HEAVY:
                [mUIImpactFeedbackGenerator initWithStyle:UIImpactFeedbackStyleHeavy];
                break;
                
            case IMPACT_RIGID:
                if (@available(iOS 13.0, *)) {
                    [mUIImpactFeedbackGenerator initWithStyle:UIImpactFeedbackStyleRigid];
                } else {
                    // Fallback on earlier versions
                }
                break;
            case IMPACT_SOFT:
                if (@available(iOS 13.0, *)) {
                    [mUIImpactFeedbackGenerator initWithStyle:UIImpactFeedbackStyleSoft];
                } else {
                    // Fallback on earlier versions
                }
                break;

            default:
                break;
                
        }
        
        [mUIImpactFeedbackGenerator prepare];
        
        [mUIImpactFeedbackGenerator impactOccurred];
    }
	
	
	
	
	
	
	
	else
	if(kind < 30)
    {
        UISelectionFeedbackGenerator *mUISelectionFeedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
        
        [mUISelectionFeedbackGenerator prepare];
        
        [mUISelectionFeedbackGenerator selectionChanged];
    }
	
	
	
	
	else
        if(kind < 30)
        {
            self.mUINotificationFeedbackGenerator = [[UINotificationFeedbackGenerator alloc] init];
            
            [self.mUINotificationFeedbackGenerator prepare];
            
            switch ((yy_taptic_engine) kind)
            {
                case NOTIFICATION_SUCCESS:
                    [self.mUINotificationFeedbackGenerator notificationOccurred:UINotificationFeedbackTypeSuccess];
                    break;
                    
                case NOTIFICATION_WARNING:
                    [self.mUINotificationFeedbackGenerator notificationOccurred:UINotificationFeedbackTypeWarning];
                    break;
                    
                case NOTIFICATION_ERROR:
                    [self.mUINotificationFeedbackGenerator notificationOccurred:UINotificationFeedbackTypeError];
                    break;
                    
                default:
                    break;
            }
        }
}

@end

