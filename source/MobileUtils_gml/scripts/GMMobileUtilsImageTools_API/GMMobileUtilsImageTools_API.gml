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

// Skipping function image_width (no wrapper is required)


// Skipping function image_height (no wrapper is required)


// Skipping function image_resize (no wrapper is required)


/**
 * @param {String} _path
 * @param {Real} _width
 * @param {Real} _height
 * @param {Real} _offset_x
 * @param {Real} _offset_y
 * @returns {Bool}
 */
function image_crop(_path, _width, _height, _offset_x, _offset_y)
{
    var __available__ = __GMMobileUtilsImageTools_is_available();
    if (!__available__) return;

    var __args_buffer__ = __ext_core_get_args_buffer();

    // param: _path, type: String
    if (!is_string(_path)) show_error($"{_GMFUNCTION_} :: _path expected string", true);
    buffer_write(__args_buffer__, buffer_u32, string_byte_length(_path));
    buffer_write(__args_buffer__, buffer_string, _path);

    // param: _width, type: Float64
    if (!is_numeric(_width)) show_error($"{_GMFUNCTION_} :: _width expected number", true);
    buffer_write(__args_buffer__, buffer_f64, _width);

    // param: _height, type: Float64
    if (!is_numeric(_height)) show_error($"{_GMFUNCTION_} :: _height expected number", true);
    buffer_write(__args_buffer__, buffer_f64, _height);

    // param: _offset_x, type: Float64
    if (!is_numeric(_offset_x)) show_error($"{_GMFUNCTION_} :: _offset_x expected number", true);
    buffer_write(__args_buffer__, buffer_f64, _offset_x);

    // param: _offset_y, type: Float64
    if (!is_numeric(_offset_y)) show_error($"{_GMFUNCTION_} :: _offset_y expected number", true);
    buffer_write(__args_buffer__, buffer_f64, _offset_y);

    var __return_value__ = __image_crop(buffer_get_address(__args_buffer__), buffer_tell(__args_buffer__));

    return bool(__return_value__);
}

/// @ignore
function __GMMobileUtilsImageTools_get_decoders()
{
    static __decoders__ = [];
    return __decoders__;
}
/// @ignore
function __GMMobileUtilsImageTools_is_available()
{
    static __available__ = extension_exists("GMMobileUtilsImageTools");
    return __available__;
}
// #####################################################################
// # Exports
// #####################################################################

#export image_crop
