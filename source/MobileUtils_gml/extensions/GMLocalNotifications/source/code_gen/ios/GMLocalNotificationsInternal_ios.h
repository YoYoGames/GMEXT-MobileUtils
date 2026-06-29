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
    enum class MobileUtilsNotificationPermission : std::int32_t
    {
        Unknown = 0,
        NotDetermined = 1,
        Denied = 2,
        Authorized = 3,
        Provisional = 4,
        Ephemeral = 5
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

@protocol GMLocalNotificationsInterface <NSObject>
- (void)mobile_utils_notification_create:(std::string_view)identifier seconds:(double)seconds title:(std::string_view)title message:(std::string_view)message data:(std::string_view)data;
- (void)mobile_utils_notification_create_ext:(std::string_view)identifier seconds:(double)seconds title:(std::string_view)title message:(std::string_view)message data:(std::string_view)data image_path:(std::string_view)image_path;
- (void)mobile_utils_notification_cancel:(std::string_view)identifier;
- (void)mobile_utils_notification_set_listener:(gm::wire::GMFunction)callback;
- (void)mobile_utils_notification_request_permission:(gm::wire::GMFunction)callback;
- (void)mobile_utils_notification_permission_status:(gm::wire::GMFunction)callback;
@end


@interface GMLocalNotificationsInternal : NSObject
- (double)__EXT_NATIVE__mobile_utils_notification_create:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__mobile_utils_notification_create_ext:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__mobile_utils_notification_cancel:(char*)identifier;
- (double)__EXT_NATIVE__mobile_utils_notification_set_listener:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__mobile_utils_notification_request_permission:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__mobile_utils_notification_permission_status:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__GMLocalNotifications_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length;
@end


