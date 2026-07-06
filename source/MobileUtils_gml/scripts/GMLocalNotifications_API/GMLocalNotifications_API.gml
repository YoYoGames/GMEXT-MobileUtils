// ##### extgen :: Auto-generated file do not edit!! #####

// #####################################################################
// # Macros
// #####################################################################

// #####################################################################
// # Enums
// #####################################################################

enum MobileUtilsNotificationPermission
{
    Unknown = 0,
    NotDetermined = 1,
    Denied = 2,
    Authorized = 3,
    Provisional = 4,
    Ephemeral = 5
}

// #####################################################################
// # Constructors
// #####################################################################

// #####################################################################
// # Codecs
// #####################################################################

// #####################################################################
// # Functions
// #####################################################################

/**
 * @param {String} _identifier
 * @param {Real} _seconds
 * @param {String} _title
 * @param {String} _message
 * @param {String} _data
 */
function mobile_utils_notification_create(_identifier, _seconds, _title, _message, _data)
{
    static __available = __GMLocalNotifications_is_available();
    if (!__available) return;

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _identifier, type: String
    if (!is_string(_identifier)) show_error($"{_GMFUNCTION_} :: _identifier expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_identifier));
    buffer_write(__args_buffer, buffer_string, _identifier);

    // param: _seconds, type: Float64
    if (!is_numeric(_seconds)) show_error($"{_GMFUNCTION_} :: _seconds expected number", true);
    buffer_write(__args_buffer, buffer_f64, _seconds);

    // param: _title, type: String
    if (!is_string(_title)) show_error($"{_GMFUNCTION_} :: _title expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_title));
    buffer_write(__args_buffer, buffer_string, _title);

    // param: _message, type: String
    if (!is_string(_message)) show_error($"{_GMFUNCTION_} :: _message expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_message));
    buffer_write(__args_buffer, buffer_string, _message);

    // param: _data, type: String
    if (!is_string(_data)) show_error($"{_GMFUNCTION_} :: _data expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_data));
    buffer_write(__args_buffer, buffer_string, _data);

    var _return_value = __mobile_utils_notification_create(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {String} _identifier
 * @param {Real} _seconds
 * @param {String} _title
 * @param {String} _message
 * @param {String} _data
 * @param {String} _image_path
 */
function mobile_utils_notification_create_ext(_identifier, _seconds, _title, _message, _data, _image_path)
{
    static __available = __GMLocalNotifications_is_available();
    if (!__available) return;

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _identifier, type: String
    if (!is_string(_identifier)) show_error($"{_GMFUNCTION_} :: _identifier expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_identifier));
    buffer_write(__args_buffer, buffer_string, _identifier);

    // param: _seconds, type: Float64
    if (!is_numeric(_seconds)) show_error($"{_GMFUNCTION_} :: _seconds expected number", true);
    buffer_write(__args_buffer, buffer_f64, _seconds);

    // param: _title, type: String
    if (!is_string(_title)) show_error($"{_GMFUNCTION_} :: _title expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_title));
    buffer_write(__args_buffer, buffer_string, _title);

    // param: _message, type: String
    if (!is_string(_message)) show_error($"{_GMFUNCTION_} :: _message expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_message));
    buffer_write(__args_buffer, buffer_string, _message);

    // param: _data, type: String
    if (!is_string(_data)) show_error($"{_GMFUNCTION_} :: _data expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_data));
    buffer_write(__args_buffer, buffer_string, _data);

    // param: _image_path, type: String
    if (!is_string(_image_path)) show_error($"{_GMFUNCTION_} :: _image_path expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_image_path));
    buffer_write(__args_buffer, buffer_string, _image_path);

    var _return_value = __mobile_utils_notification_create_ext(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function mobile_utils_notification_cancel (no wrapper is required)


/**
 * @param {Function} _callback
 */
function mobile_utils_notification_set_listener(_callback)
{
    static __available = __GMLocalNotifications_is_available();
    if (!__available) return;

    static __dispatcher = __GMLocalNotifications_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mobile_utils_notification_set_listener(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {Function} _callback
 */
function mobile_utils_notification_request_permission(_callback)
{
    static __available = __GMLocalNotifications_is_available();
    if (!__available) return;

    static __dispatcher = __GMLocalNotifications_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mobile_utils_notification_request_permission(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {Function} _callback
 */
function mobile_utils_notification_permission_status(_callback)
{
    static __available = __GMLocalNotifications_is_available();
    if (!__available) return;

    static __dispatcher = __GMLocalNotifications_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mobile_utils_notification_permission_status(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/// @ignore
function __GMLocalNotifications_get_decoders()
{
    static __decoders = [];
    return __decoders;
}
/// @ignore
function __GMLocalNotifications_get_dispatcher()
{
    static __available = __GMLocalNotifications_is_available();
    if (!__available) return;

    static __dispatcher = new __GMNativeFunctionDispatcher(__GMLocalNotifications_invocation_handler, __GMLocalNotifications_get_decoders());
    return __dispatcher;
}
/// @ignore
function __GMLocalNotifications_is_available()
{
    static __available = extension_exists("GMLocalNotifications");
    return __available;
}
