
// FUNCTIONS

/**
 * @function mobile_utils_app_popup_settings_show
 * @desc This function opens the operating system's Settings page for your application.
 *
 * This is useful for directing the player to the system settings when a permission they previously denied needs to be granted manually (the app cannot change those settings itself).
 *
 * This is an asynchronous function: the `callback` method reports whether the operating system accepted the request to open the settings page.
 *
 * @param {Function} callback The method to call once the request to open the settings page has been made
 *
 * @event callback
 * @desc This callback is triggered when the request to open the application settings page has been made.
 * @member {Bool} success Whether the operating system accepted the request to open the settings page
 * @member {String} error The error message (empty when `success` is `true`)
 * @event_end
 *
 * @example
 * ```gml
 * mobile_utils_app_popup_settings_show(function(_success, _error)
 * {
 *     if (_success) show_debug_message("Application settings opened.");
 *     else show_debug_message("Could not open settings: " + _error);
 * });
 * ```
 * The code above opens this application's system settings page and logs the outcome.
 * @function_end
 */

// MODULES

/**
 * @module settings
 * @title Settings
 * @desc This module opens the application's system settings page on **Android** and **iOS**.
 *
 * @section_func
 * @desc The following function is provided:
 * @ref mobile_utils_app_popup_settings_show
 * @section_end
 *
 * @module_end
 */
