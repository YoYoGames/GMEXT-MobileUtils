#import "GMMobileUtilsMicrophone_ios.h"
#import <AVFoundation/AVFoundation.h>

@implementation GMMobileUtilsMicrophone

// Fire-and-forget by design (see spec.gmidl) — call mobile_utils_mic_check
// afterward (e.g. on the next room step or app resume) to read the result.
// iOS shows its own system permission dialog; requesting again once the user
// has already answered is a harmless no-op (the block fires immediately with
// the existing answer).
- (void)mobile_utils_mic_request
{
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        (void)granted;
    }];
}

- (void)mobile_utils_mic_check:(gm::wire::GMFunction)callback
{
    gm_enums::MobileUtilsMicPermission status;

    switch ([[AVAudioSession sharedInstance] recordPermission])
    {
        case AVAudioSessionRecordPermissionGranted:
            status = gm_enums::MobileUtilsMicPermission::Granted;
            break;
        case AVAudioSessionRecordPermissionDenied:
            status = gm_enums::MobileUtilsMicPermission::Denied;
            break;
        case AVAudioSessionRecordPermissionUndetermined:
        default:
            status = gm_enums::MobileUtilsMicPermission::NotDetermined;
            break;
    }

    callback.call(status);
}

@end
