#import <CoreHaptics/CoreHaptics.h>
#import <UIKit/UIKit.h>

#import "GMMobileUtilsVibrate_ios.h"

@implementation GMMobileUtilsVibrate
{
    CHHapticEngine *_hapticEngine;
}

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        if (@available(iOS 13.0, *))
        {
            NSError *error = nil;

            _hapticEngine =
                [[CHHapticEngine alloc]
                    initAndReturnError:&error];

            if (_hapticEngine != nil)
                [_hapticEngine startAndReturnError:nil];
        }
    }

    return self;
}

- (double)mobile_utils_vibrate_is_available
{
    if (@available(iOS 13.0, *))
    {
        if ([CHHapticEngine capabilitiesForHardware].supportsHaptics)
            return 2.0;
    }

    /*
     * UIFeedbackGenerator may still provide basic feedback on supported
     * pre-iOS-13 devices. Do not use the private _feedbackSupportLevel key.
     */
    return 1.0;
}

- (bool)mobile_utils_vibrate_predefined:(double)kind
{
    int value = (int)kind;

    switch (value)
    {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        {
            UIImpactFeedbackStyle style =
                UIImpactFeedbackStyleMedium;

            switch (value)
            {
                case 0:
                    style = UIImpactFeedbackStyleLight;
                    break;

                case 1:
                    style = UIImpactFeedbackStyleMedium;
                    break;

                case 2:
                    style = UIImpactFeedbackStyleHeavy;
                    break;

                case 3:
                    if (@available(iOS 13.0, *))
                        style = UIImpactFeedbackStyleRigid;
                    else
                        return false;
                    break;

                case 4:
                    if (@available(iOS 13.0, *))
                        style = UIImpactFeedbackStyleSoft;
                    else
                        return false;
                    break;
            }

            UIImpactFeedbackGenerator *generator =
                [[UIImpactFeedbackGenerator alloc]
                    initWithStyle:style];

            [generator prepare];
            [generator impactOccurred];

            return true;
        }

        case 10:
        {
            UISelectionFeedbackGenerator *generator =
                [[UISelectionFeedbackGenerator alloc] init];

            [generator prepare];
            [generator selectionChanged];

            return true;
        }

        case 20:
        case 21:
        case 22:
        {
            UINotificationFeedbackType type =
                UINotificationFeedbackTypeWarning;

            if (value == 21)
                type = UINotificationFeedbackTypeSuccess;
            else if (value == 22)
                type = UINotificationFeedbackTypeError;

            UINotificationFeedbackGenerator *generator =
                [[UINotificationFeedbackGenerator alloc] init];

            [generator prepare];
            [generator notificationOccurred:type];

            return true;
        }

        default:
            return false;
    }
}

- (bool)mobile_utils_vibrate_shot:(double)milliseconds
{
    if (milliseconds <= 0.0)
        return false;

    if (@available(iOS 13.0, *))
    {
        if (_hapticEngine == nil)
            return false;

        CHHapticEventParameter *intensity =
            [[CHHapticEventParameter alloc]
                initWithParameterID:
                    CHHapticEventParameterIDHapticIntensity
                value:1.0];

        CHHapticEventParameter *sharpness =
            [[CHHapticEventParameter alloc]
                initWithParameterID:
                    CHHapticEventParameterIDHapticSharpness
                value:0.5];

        CHHapticEvent *event =
            [[CHHapticEvent alloc]
                initWithEventType:
                    CHHapticEventTypeHapticContinuous
                parameters:@[intensity, sharpness]
                relativeTime:0
                duration:milliseconds / 1000.0];

        NSError *error = nil;

        CHHapticPattern *pattern =
            [[CHHapticPattern alloc]
                initWithEvents:@[event]
                parameters:@[]
                error:&error];

        if (pattern == nil)
            return false;

        id<CHHapticPatternPlayer> player =
            [_hapticEngine
                createPlayerWithPattern:pattern
                error:&error];

        if (player == nil)
            return false;

        return [player startAtTime:0 error:&error];
    }

    return [self mobile_utils_vibrate_predefined:1.0];
}

@end
