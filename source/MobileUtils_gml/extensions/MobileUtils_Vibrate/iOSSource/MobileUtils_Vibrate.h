
#import <UIKit/UIKit.h>

@interface TapticEngine:NSObject
{
    NSMutableDictionary *ListenerMap;
    
}

@property(nonatomic, strong) UIImpactFeedbackGenerator *mUIImpactFeedbackGenerator;
@property(nonatomic, strong) UISelectionFeedbackGenerator *mUISelectionFeedbackGenerator;
@property(nonatomic, strong) UINotificationFeedbackGenerator *mUINotificationFeedbackGenerator;

@end


