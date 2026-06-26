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

@protocol GMMobileUtilsAPNInterface <NSObject>
- (void)mobile_utils_apn_register:(gm::wire::GMFunction)callback;
- (std::string)mobile_utils_apn_get_token;
@end


@interface GMMobileUtilsAPNInternal : NSObject
- (double)__EXT_NATIVE__mobile_utils_apn_register:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (char*)__EXT_NATIVE__mobile_utils_apn_get_token;
- (double)__EXT_NATIVE__GMMobileUtilsAPN_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length;
@end


