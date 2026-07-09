
// FUNCTIONS

/**
 * @function mobile_utils_mic_request
 * @desc This function requests the microphone (audio recording) permission, prompting the player if required.
 *
 * On Android this triggers the runtime `RECORD_AUDIO` prompt; on iOS it triggers the system microphone access prompt. If permission has already been granted or denied, the call is a harmless no-op — the OS answers immediately without showing a dialog again.
 *
 * [[Note: This function does not report the outcome directly. Call ${function.mobile_utils_mic_check} afterward (for example on the next room step or when the app resumes) to read the result.]]
 *
 * @example
 * ```gml
 * mobile_utils_mic_request();
 * ```
 * The code above prompts the player for microphone access if it has not been decided yet.
 * @function_end
 */

/**
 * @function mobile_utils_mic_check
 * @desc This function queries the current microphone permission status without prompting the player.
 *
 * The status passed to the callback is a member of the ${constant.MobileUtilsMicPermission} enumeration.
 *
 * [[Note: On Android, `NotDetermined` covers both "never asked" and "permanently denied" (`Don't ask again`) — the OS does not expose a way to tell these apart other than attempting the request via ${function.mobile_utils_mic_request} and checking again.]]
 *
 * @param {Function} callback The method to call with the current permission status
 *
 * @event callback
 * @desc This callback is triggered with the current microphone permission status.
 * @member {Constant.MobileUtilsMicPermission} status The current microphone permission status
 * @event_end
 *
 * @example
 * ```gml
 * mobile_utils_mic_check(function(_status)
 * {
 *     if (_status == MobileUtilsMicPermission.NotDetermined)
 *     {
 *         mobile_utils_mic_request();
 *     }
 * });
 * ```
 * The code above checks the microphone permission and requests it only if it has not been decided yet.
 * @function_end
 */

// CONSTANTS

/**
 * @const MobileUtilsMicPermission
 * @desc This enumeration contains the possible microphone permission states reported by ${function.mobile_utils_mic_check}.
 * @member Unknown The permission state could not be determined (for example, no activity is available).
 * @member NotDetermined The player has not yet been asked for permission (Android: this also covers a permanent "Don't ask again" denial).
 * @member Denied Microphone access is not permitted.
 * @member Granted Microphone access is permitted.
 * @const_end
 */

// MODULES

/**
 * @module microphone
 * @title Microphone
 * @desc This module requests and queries the microphone (audio recording) permission on **Android** and **iOS**.
 *
 * @section_func
 * @desc The following functions are provided to work with microphone permission:
 * @ref mobile_utils_mic_request
 * @ref mobile_utils_mic_check
 * @section_end
 *
 * @section_const
 * @desc The following constant is used by this module:
 * @ref MobileUtilsMicPermission
 * @section_end
 *
 * @module_end
 */
