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

@protocol GMMobileUtilsAppPopupSettingsInterface <NSObject>
- (void)mobile_utils_app_popup_settings_show:(gm::wire::GMFunction)callback;
@end


@interface GMMobileUtilsAppPopupSettingsInternal : NSObject
- (double)__EXT_NATIVE__mobile_utils_app_popup_settings_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__GMMobileUtilsAppPopupSettings_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length;
@end


