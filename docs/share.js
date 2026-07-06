
// FUNCTIONS

/**
 * @function mobile_utils_share_open
 * @desc This function presents the native share sheet so the player can share text or a file with another application.
 *
 * The `mime` argument selects what is shared. For a text MIME type (`text/plain`, `text/rtf`, `text/html`, `text/json` or `application/json`) the `value` is the text to share. For any other MIME type the `value` is a filename resolved relative to the application's storage area, and that file is shared. An empty `mime` defaults to `*/*` on Android.
 *
 * [[Note: The `success` reported to the callback means the share sheet was successfully presented — it does not indicate whether the player actually completed a share, which the operating system does not report back.]]
 * [[Note: To share a file it must first exist inside the application's storage. A typical pattern is to `file_copy` an included file into the sandbox and pass that filename as `value`.]]
 *
 * @param {String} title The title shown on the share chooser
 * @param {String} mime The MIME type of the content being shared (e.g. `"text/plain"`, `"image/jpeg"`, `"application/pdf"`)
 * @param {String} value The text to share (text MIME types) or the filename to share (other MIME types)
 * @param {Function} callback The method to call once the share sheet has been presented
 *
 * @event callback
 * @desc This callback is triggered when the share sheet has been presented (or failed to present).
 * @member {Bool} success Whether the share sheet was successfully presented
 * @member {String} error The error message (empty when `success` is `true`)
 * @event_end
 *
 * @example
 * ```gml
 * // Share a line of text.
 * mobile_utils_share_open("Title!", "text/plain", "Hello World", function(_success, _error)
 * {
 *     if (!_success) show_debug_message("Share failed: " + _error);
 * });
 *
 * // Share an image file (copied into the sandbox first).
 * var _file = "shared_image.jpg";
 * file_copy("YYImage.jpg", _file);
 * mobile_utils_share_open("Title!", "image/jpeg", _file, function(_success, _error) {});
 * ```
 * The code above shares a text string and, separately, an image file through the native share sheet.
 * @function_end
 */

// MODULES

/**
 * @module share
 * @title Share
 * @desc This module presents the native share sheet for sharing text and files on **Android** and **iOS**.
 *
 * @section_func
 * @desc The following function is provided to share content:
 * @ref mobile_utils_share_open
 * @section_end
 *
 * @module_end
 */
