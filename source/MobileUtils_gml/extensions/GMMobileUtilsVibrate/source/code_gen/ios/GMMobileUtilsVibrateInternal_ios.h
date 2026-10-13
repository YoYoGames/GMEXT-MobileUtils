// ##### extgen :: Auto-generated file do not edit!! #####

#pragma once
#import <Foundation/Foundation.h>

#include <cstdint>
#include <string_view>
#include <vector>
#include <array>
#include <optional>
#include "core/GMExtWire.h"

namespace gm_consts
{
}


namespace gm_enums
{
    enum class VibrationAvailability : std::int32_t
    {
        None = 0,
        Basic = 1,
        HapticEngine = 2
    };

    enum class AndroidVibrationKind : std::int32_t
    {
        Click = 0,
        DoubleClick = 1,
        Tick = 2,
        HeavyClick = 5
    };

    enum class IOSVibrationKind : std::int32_t
    {
        ImpactLight = 0,
        ImpactMedium = 1,
        ImpactHeavy = 2,
        ImpactRigid = 3,
        ImpactSoft = 4,
        Selection = 10,
        NotificationWarning = 20,
        NotificationSuccess = 21,
        NotificationError = 22
    };

}


namespace gm_structs
{

}

namespace gm::wire::codec
{
}

namespace gm::wire::details
{
}

@protocol GMMobileUtilsVibrateInterface <NSObject>
- (double)vibrate_is_available;
- (bool)vibrate_predefined:(double)kind;
- (bool)vibrate_shot:(double)milliseconds;
@end


@interface GMMobileUtilsVibrateInternal : NSObject
- (double)__EXT_NATIVE__vibrate_is_available;
- (double)__EXT_NATIVE__vibrate_predefined:(double)kind;
- (double)__EXT_NATIVE__vibrate_shot:(double)milliseconds;
@end


