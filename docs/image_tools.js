
// FUNCTIONS

/**
 * @function mobile_utils_image_width
 * @desc This function returns the width, in pixels, of the image at the given path.
 *
 * The image is inspected on disk without being fully loaded into memory.
 *
 * @param {String} path The path to the image file
 * @returns {Real} The image width in pixels, or `-1` if the file could not be read
 *
 * @example
 * ```gml
 * var _w = mobile_utils_image_width(path);
 * if (_w == -1) show_debug_message("Could not read image");
 * ```
 * The code above reads the width of an image and checks for the failure value.
 * @function_end
 */

/**
 * @function mobile_utils_image_height
 * @desc This function returns the height, in pixels, of the image at the given path.
 *
 * The image is inspected on disk without being fully loaded into memory.
 *
 * @param {String} path The path to the image file
 * @returns {Real} The image height in pixels, or `-1` if the file could not be read
 *
 * @example
 * ```gml
 * var _h = mobile_utils_image_height(path);
 * ```
 * The code above reads the height of an image.
 * @function_end
 */

/**
 * @function mobile_utils_image_resize
 * @desc This function resizes the image at the given path to the requested pixel dimensions, overwriting the file in place.
 *
 * The output format is chosen from the file extension: a `.jpg`/`.jpeg` path is written as JPEG, any other extension as PNG. The image is written to a temporary file and then moved over the original, so a failed encode does not destroy the source file.
 *
 * [[Warning: This function runs synchronously on the calling thread. Resizing a multi-megapixel image can block for a noticeable amount of time; avoid calling it every frame.]]
 *
 * @param {String} path The path to the image file to resize (overwritten in place)
 * @param {Real} width The target width in pixels (must be greater than 0)
 * @param {Real} height The target height in pixels (must be greater than 0)
 * @returns {Bool} `true` if the image was resized and saved, `false` on invalid dimensions or a read/write failure
 *
 * @example
 * ```gml
 * if (mobile_utils_image_resize(path, 256, 256))
 * {
 *     show_debug_message("Resized");
 * }
 * ```
 * The code above resizes an image to 256x256 pixels in place.
 * @function_end
 */

/**
 * @function mobile_utils_image_crop
 * @desc This function crops the image at the given path to a rectangle, overwriting the file in place.
 *
 * The crop rectangle is defined by its size (`width` x `height`) and its top-left origin (`offset_x`, `offset_y`), all in pixels. The rectangle must lie fully within the source image. As with ${function.mobile_utils_image_resize}, the output format follows the file extension and the write is performed via a temporary file.
 *
 * [[Warning: This function runs synchronously on the calling thread and can block on large images.]]
 *
 * @param {String} path The path to the image file to crop (overwritten in place)
 * @param {Real} width The width of the crop rectangle in pixels (must be greater than 0)
 * @param {Real} height The height of the crop rectangle in pixels (must be greater than 0)
 * @param {Real} offset_x The x coordinate of the crop rectangle's top-left corner, in pixels
 * @param {Real} offset_y The y coordinate of the crop rectangle's top-left corner, in pixels
 * @returns {Bool} `true` if the image was cropped and saved, `false` on an out-of-bounds rectangle or a read/write failure
 *
 * @example
 * ```gml
 * // Crop the image to a centered square, then scale it down.
 * var _w = mobile_utils_image_width(path);
 * var _h = mobile_utils_image_height(path);
 * if (_w > _h) mobile_utils_image_crop(path, _h, _h, (_w - _h) / 2, 0);
 * else         mobile_utils_image_crop(path, _w, _w, 0, (_h - _w) / 2);
 * mobile_utils_image_resize(path, 300, 300);
 * ```
 * The code above crops an image to a centered square and resizes it to 300x300 pixels.
 * @function_end
 */

// MODULES

/**
 * @module image_tools
 * @title Image Tools
 * @desc This module provides synchronous, on-disk image operations (reading dimensions, resizing and cropping) on **Android** and **iOS**.
 *
 * The resize and crop functions overwrite the file at the given path. Because they run synchronously they are best used off the main gameplay path when working with large images.
 *
 * @section_func
 * @desc The following functions are provided to work with images:
 * @ref mobile_utils_image_width
 * @ref mobile_utils_image_height
 * @ref mobile_utils_image_resize
 * @ref mobile_utils_image_crop
 * @section_end
 *
 * @module_end
 */
