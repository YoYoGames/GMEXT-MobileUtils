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
 * @param {String} _title
 * @param {String} _mime
 * @param {String} _value
 * @param {Function} _callback
 */
function mobile_utils_share_open(_title, _mime, _value, _callback)
{
    static __available = __GMMobileUtilsShare_is_available();
    if (!__available) return;

    static __dispatcher = __GMMobileUtilsShare_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _title, type: String
    if (!is_string(_title)) show_error($"{_GMFUNCTION_} :: _title expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_title));
    buffer_write(__args_buffer, buffer_string, _title);

    // param: _mime, type: String
    if (!is_string(_mime)) show_error($"{_GMFUNCTION_} :: _mime expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_mime));
    buffer_write(__args_buffer, buffer_string, _mime);

    // param: _value, type: String
    if (!is_string(_value)) show_error($"{_GMFUNCTION_} :: _value expected string", true);
    buffer_write(__args_buffer, buffer_u32, string_byte_length(_value));
    buffer_write(__args_buffer, buffer_string, _value);

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __mobile_utils_share_open(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/// @ignore
function __GMMobileUtilsShare_get_decoders()
{
    static __decoders = [];
    return __decoders;
}
/// @ignore
function __GMMobileUtilsShare_get_dispatcher()
{
    static __available = __GMMobileUtilsShare_is_available();
    if (!__available) return;

    static __dispatcher = new __GMNativeFunctionDispatcher(__GMMobileUtilsShare_invocation_handler, __GMMobileUtilsShare_get_decoders());
    return __dispatcher;
}
/// @ignore
function __GMMobileUtilsShare_is_available()
{
    static __available = extension_exists("GMMobileUtilsShare");
    return __available;
}
