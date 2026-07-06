
// FUNCTIONS

/**
 * @function mobile_utils_apn_register
 * @desc This function registers the device for Apple Push Notifications (APNs) and returns the resulting device token.
 *
 * Registration requests notification authorization and then asks Apple for a device token. Once obtained the token is cached for the rest of the process, so subsequent calls return it immediately. Send the token to your push backend so it can address this device.
 *
 * [[Note: This is an iOS-only, experimental feature. On Android the function is not implemented and does nothing; guard your call with `os_type == os_ios`. Set the APS Environment extension option to `production` for release builds (see ${page.extension_options}).]]
 *
 * @param {Function} callback The method to call once registration finishes
 *
 * @event callback
 * @desc This callback is triggered when APNs registration finishes.
 * @member {Bool} success Whether a device token was obtained
 * @member {String} token The APNs device token as a hex string (empty when `success` is `false`)
 * @member {String} error The error message (empty when `success` is `true`)
 * @event_end
 *
 * @example
 * ```gml
 * if (os_type != os_ios) return;
 * mobile_utils_apn_register(function(_success, _token, _error)
 * {
 *     if (_success) show_debug_message("Device token: " + _token);
 *     else show_debug_message("APNs registration failed: " + _error);
 * });
 * ```
 * The code above registers for push notifications on iOS and logs the device token.
 * @function_end
 */

/**
 * @function mobile_utils_apn_get_token
 * @desc This function returns the APNs device token obtained by ${function.mobile_utils_apn_register} earlier in this session.
 *
 * [[Note: This is an iOS-only, experimental feature. It returns an empty string if registration has not completed (or on Android).]]
 *
 * @returns {String} The cached APNs device token, or an empty string if none is available
 *
 * @example
 * ```gml
 * var _token = mobile_utils_apn_get_token();
 * if (_token != "") show_debug_message("Token: " + _token);
 * ```
 * The code above reads the cached push token and uses it if one is available.
 * @function_end
 */

// MODULES

/**
 * @module apn
 * @title Push Notifications (APNs)
 * @desc This module registers for Apple Push Notifications and exposes the device token. It is **iOS-only and experimental** — the functions do nothing on Android, so guard calls with `os_type == os_ios`.
 *
 * @section_func
 * @desc The following functions are provided to work with push notifications:
 * @ref mobile_utils_apn_register
 * @ref mobile_utils_apn_get_token
 * @section_end
 *
 * @module_end
 */
