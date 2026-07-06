
// FUNCTIONS

/**
 * @function mobile_utils_gallery_open
 * @desc This function opens the device's photo gallery so the player can pick an image.
 *
 * This is an asynchronous function: once the player selects an image (or cancels), the `callback` method is invoked with the outcome. On success the chosen image is copied into the application's storage area and both its absolute path and its base filename are passed to the callback.
 *
 * [[Note: On iOS the photo-library permission is requested automatically; the prompt text comes from the Photo Usage Description extension option (see ${page.extension_options}).]]
 *
 * @param {Function} callback The method to call once the selection finishes
 *
 * @event callback
 * @desc This callback is triggered when the gallery selection finishes.
 * @member {Bool} success Whether an image was selected and copied
 * @member {String} path The absolute path to the copied image (empty when `success` is `false`)
 * @member {String} filename The base filename of the selected image (empty when `success` is `false`)
 * @member {String} error The error message (empty when `success` is `true`; e.g. the selection was cancelled)
 * @event_end
 *
 * @example
 * ```gml
 * mobile_utils_gallery_open(function(_success, _path, _filename, _error)
 * {
 *     if (!_success)
 *     {
 *         show_debug_message("Gallery failed: " + _error);
 *         return;
 *     }
 *     show_debug_message($"Selected {_filename}");
 *     sprite = sprite_add(_path, 1, false, false, 0, 0);
 *     if (file_exists(_path)) file_delete(_path);
 * });
 * ```
 * The code above lets the player pick an image, loads it into a sprite and then removes the temporary copy.
 * @function_end
 */

// MODULES

/**
 * @module gallery
 * @title Gallery
 * @desc This module lets the player pick an image from the device's photo gallery on **Android** and **iOS**.
 *
 * @section_func
 * @desc The following function is provided to work with the gallery:
 * @ref mobile_utils_gallery_open
 * @section_end
 *
 * @module_end
 */
