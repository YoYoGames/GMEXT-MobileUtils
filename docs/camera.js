
// FUNCTIONS

/**
 * @function mobile_utils_camera_open
 * @desc This function brings up the device camera so the player can take a photo.
 *
 * This is an asynchronous function: it does not return the captured image directly. Instead, once the player takes a photo (or cancels), the `callback` method is invoked with the outcome. On success the photo is written to a file in the application's storage area and its absolute path is passed to the callback.
 *
 * [[Note: On iOS the camera permission is requested automatically the first time the camera is opened; the prompt text comes from the Camera Usage Description extension option (see ${page.extension_options}). On Android the capture is delegated to the system camera app, so no `CAMERA` permission is required.]]
 * [[Warning: On Android the captured image is the camera app's thumbnail bitmap (reduced resolution) and is saved as a PNG, whereas iOS saves a full JPEG. Account for this difference when displaying or uploading the result.]]
 *
 * @param {Function} callback The method to call once the capture attempt finishes
 *
 * @event callback
 * @desc This callback is triggered when the capture attempt finishes.
 * @member {Bool} success Whether a photo was captured and saved
 * @member {String} path The absolute path to the saved image (empty when `success` is `false`)
 * @member {String} error The error message (empty when `success` is `true`; e.g. the capture was cancelled)
 * @event_end
 *
 * @example
 * ```gml
 * mobile_utils_camera_open(function(_success, _path, _error)
 * {
 *     if (!_success)
 *     {
 *         show_debug_message("Camera failed: " + _error);
 *         return;
 *     }
 *     sprite = sprite_add(_path, 1, false, false, 0, 0);
 * });
 * ```
 * The code above opens the camera and, when a photo is taken, loads the saved image into a sprite.
 * @function_end
 */

// MODULES

/**
 * @module camera
 * @title Camera
 * @desc This module provides interaction with the device's camera on **Android** and **iOS**.
 *
 * @section_func
 * @desc The following function is provided to work with the camera:
 * @ref mobile_utils_camera_open
 * @section_end
 *
 * @module_end
 */
