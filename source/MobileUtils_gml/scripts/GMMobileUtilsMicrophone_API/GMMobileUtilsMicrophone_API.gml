// ##### extgen :: Auto-generated file do not edit!! #####

// #####################################################################
// # Macros
// #####################################################################

// #####################################################################
// # Enums
// #####################################################################

enum MobileUtilsMicPermission
{
    Unknown = 0,
    NotDetermined = 1,
    Denied = 2,
    Granted = 3
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

// Skipping function mobile_utils_mic_request (no wrapper is required)


/**
 * @param {Function} _callback
 */
function mobile_utils_mic_check(_callback)
{
    var __available = __GMMobileUtilsMicrophone_is_available();
    if (!__available) return;

    var __dispatcher = __GMMobileUtilsMicrophone_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mobile_utils_mic_check(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/// @ignore
function __GMMobileUtilsMicrophone_get_decoders()
{
    static __decoders = [];
    return __decoders;
}
/// @ignore
function __GMMobileUtilsMicrophone_get_dispatcher()
{
    static __dispatcher = new __GMNativeFunctionDispatcher(__GMMobileUtilsMicrophone_invocation_handler, __GMMobileUtilsMicrophone_get_decoders());
    return __dispatcher;
}
/// @ignore
function __GMMobileUtilsMicrophone_is_available()
{
    static __available = extension_exists("GMMobileUtilsMicrophone");
    return __available;
}
