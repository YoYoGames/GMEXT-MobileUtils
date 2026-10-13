#import "GMMobileUtilsMicrophone_ios.h"
#import <AVFoundation/AVFoundation.h>

@implementation GMMobileUtilsMicrophone

// Fire-and-forget by design (see spec.gmidl) — call mic_check
// afterward (e.g. on the next room step or app resume) to read the result.
// iOS shows its own system permission dialog; requesting again once the user
// has already answered is a harmless no-op (the block fires immediately with
// the existing answer).
- (void)mic_request
{
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        (void)granted;
    }];
}

- (void)mic_check:(gm::wire::GMFunction)callback
{
    gm_enums::MicPermission status;

    switch ([[AVAudioSession sharedInstance] recordPermission])
    {
        case AVAudioSessionRecordPermissionGranted:
            status = gm_enums::MicPermission::Granted;
            break;
        case AVAudioSessionRecordPermissionDenied:
            status = gm_enums::MicPermission::Denied;
            break;
        case AVAudioSessionRecordPermissionUndetermined:
        default:
            status = gm_enums::MicPermission::NotDetermined;
            break;
    }

    callback.call(status);
}

@end
