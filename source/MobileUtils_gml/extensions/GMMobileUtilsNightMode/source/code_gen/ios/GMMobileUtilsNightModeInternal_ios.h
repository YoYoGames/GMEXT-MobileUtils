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
    enum class NightMode : std::int32_t
    {
        Dark = 0,
        Light = 1,
        Undefined = 2
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

@protocol GMMobileUtilsNightModeInterface <NSObject>
- (double)night_mode_check;
@end


@interface GMMobileUtilsNightModeInternal : NSObject
- (double)__EXT_NATIVE__night_mode_check;
@end


