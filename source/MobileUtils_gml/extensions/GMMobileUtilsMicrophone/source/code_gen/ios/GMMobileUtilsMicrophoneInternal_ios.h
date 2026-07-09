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
    enum class MobileUtilsMicPermission : std::int32_t
    {
        Unknown = 0,
        NotDetermined = 1,
        Denied = 2,
        Granted = 3
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

@protocol GMMobileUtilsMicrophoneInterface <NSObject>
- (void)mobile_utils_mic_request;
- (void)mobile_utils_mic_check:(gm::wire::GMFunction)callback;
@end


@interface GMMobileUtilsMicrophoneInternal : NSObject
- (double)__EXT_NATIVE__mobile_utils_mic_request;
- (double)__EXT_NATIVE__mobile_utils_mic_check:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__GMMobileUtilsMicrophone_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length;
@end


