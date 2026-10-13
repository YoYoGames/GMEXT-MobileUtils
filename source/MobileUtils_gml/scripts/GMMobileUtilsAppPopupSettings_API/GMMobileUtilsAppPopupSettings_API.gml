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
function app_popup_settings_show(_callback)
{
    var __available__ = __GMMobileUtilsAppPopupSettings_is_available();
    if (!__available__) return;

    var __dispatcher__ = __GMMobileUtilsAppPopupSettings_get_dispatcher();

    var __args_buffer__ = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher__);
    buffer_write(__args_buffer__, buffer_u64, _callback_handle);

    var __return_value__ = __app_popup_settings_show(buffer_get_address(__args_buffer__), buffer_tell(__args_buffer__));

    return __return_value__;
}

/// @ignore
function __GMMobileUtilsAppPopupSettings_get_decoders()
{
    static __decoders__ = [];
    return __decoders__;
}
/// @ignore
function __GMMobileUtilsAppPopupSettings_get_dispatcher()
{
    static __dispatcher__ = new __GMNativeFunctionDispatcher(__GMMobileUtilsAppPopupSettings_invocation_handler, __GMMobileUtilsAppPopupSettings_get_decoders());
    return __dispatcher__;
}
/// @ignore
function __GMMobileUtilsAppPopupSettings_is_available()
{
    static __available__ = extension_exists("GMMobileUtilsAppPopupSettings");
    return __available__;
}
// #####################################################################
// # Exports
// #####################################################################

#export app_popup_settings_show
