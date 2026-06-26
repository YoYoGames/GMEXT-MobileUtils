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

@protocol GMMobileUtilsImageToolsInterface <NSObject>
- (double)mobile_utils_image_width:(std::string_view)path;
- (double)mobile_utils_image_height:(std::string_view)path;
- (bool)mobile_utils_image_resize:(std::string_view)path width:(double)width height:(double)height;
- (bool)mobile_utils_image_crop:(std::string_view)path width:(double)width height:(double)height offset_x:(double)offset_x offset_y:(double)offset_y;
@end


@interface GMMobileUtilsImageToolsInternal : NSObject
- (double)__EXT_NATIVE__mobile_utils_image_width:(char*)path;
- (double)__EXT_NATIVE__mobile_utils_image_height:(char*)path;
- (double)__EXT_NATIVE__mobile_utils_image_resize:(char*)path arg1:(double)width arg2:(double)height;
- (double)__EXT_NATIVE__mobile_utils_image_crop:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
@end


