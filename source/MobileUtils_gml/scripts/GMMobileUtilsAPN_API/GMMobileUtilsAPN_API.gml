// ##### extgen :: Auto-generated file do not edit!! #####

// #####################################################################
// # Macros
// #####################################################################

// #####################################################################
// # Enums
// #####################################################################

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
 * @param {Function} _callback
 */
function mobile_utils_apn_register(_callback)
{
    static __dispatcher = __GMMobileUtilsAPN_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mobile_utils_apn_register(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function mobile_utils_apn_get_token (no wrapper is required)


/// @ignore
function __GMMobileUtilsAPN_get_decoders()
{
    static __decoders = [];
    return __decoders;
}
/// @ignore
function __GMMobileUtilsAPN_get_dispatcher()
{
    static __dispatcher = new __GMNativeFunctionDispatcher(__GMMobileUtilsAPN_invocation_handler, __GMMobileUtilsAPN_get_decoders());
    return __dispatcher;
}
