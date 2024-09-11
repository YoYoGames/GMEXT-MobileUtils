// Functions

/**
 * @function MobileUtils_Vibrate_Shot
 * @desc This function creates a one-shot vibration.
 * 
 * A one-shot vibration will vibrate constantly for the specified period of time at the specified amplitude, and then stop.
 * 
 * [[Note: On iOS versions < 13 this function's `milliseconds` parameter is ignored and it plays a medium impact predefined effect instead (`MobileUtils_VIBRATE_KIND_IOS_IMPACT_MEDIUM`).]]
 * 
 * @param {real} milliseconds The number of milliseconds to vibrate
 * @param {real} amplitude The amplitude of the vibration. This is a value between 1 and 255, or -1 for the default
 * 
 * @example
 * ```gml
 * if(MobileUtils_Vibrate_Is_Available())
 * {
 *     MobileUtils_Vibrate_Shot(1000);
 * }
 * ```
 * The code example first checks if device vibration is available using ${function.MobileUtils_Vibrate_Is_Available}. If it is, a one-shot vibration of one second is created using ${function.MobileUtils_Vibrate_Shot}.
 * @function_end
 */

/**
 * @function MobileUtils_Vibrate_Predefined
 * @desc This function creates a predefined vibration effect.
 * 
 * [[Note: This function is unsupported on HTML5.]]
 * 
 * @param {constant.MobileUtils_VIBRATE_KIND} effectId The predefined effect to create
 * 
 * @example
 * ```gml
 * if (os_type != os_android) { exit; }
 * 
 * var _perm_vibrate = "android.permission.VIBRATE";
 * if (os_check_permission(_perm_vibrate))
 * {
 *     MobileUtils_Vibrate_Predefined(MobileUtils_VIBRATE_KIND_ANDROID_HEAVY_CLICK);
 * } else
 * {
 *     os_request_permission(_perm_vibrate);
 * }
 * ```
 * @function_end
 */

/**
 * @function MobileUtils_Vibrate_Is_Available
 * @desc This function returns if device vibration is available.
 * 
 * The function returns 0 if vibration is not available, 1 if it is and 2 if extra functionality can be used.
 * 
 * @returns {real}
 * 
 * @example
 * ```gml
 * if (MobileUtils_Vibrate_Is_Available())
 * {
 *     show_debug_message("This device supports vibration.");
 * }
 * ```
 * The code example above checks if device vibration is available using ${function.MobileUtils_Vibrate_Is_Available} and shows a debug message if true.
 * @function_end
 */

// Constants

/**
 * @constant MobileUtils_VIBRATE_KIND
 * @desc This set of constants represents the predefined vibration effects that can be used.
 * 
 * [[Note: Constants are included for both Android and iOS. You should make sure to use the right constant on the right platform.]]
 * 
 * @member MobileUtils_VIBRATE_KIND_ANDROID_CLICK A click effect on Android.
 * @member MobileUtils_VIBRATE_KIND_ANDROID_DOUBLE_CLICK A double click effect on Android.
 * @member MobileUtils_VIBRATE_KIND_ANDROID_HEAVY_CLICK A heavy click effect on Android.
 * @member MobileUtils_VIBRATE_KIND_ANDROID_TICK A tick effect on Android.
 * @member MobileUtils_VIBRATE_KIND_IOS_IMPACT_LIGHT A light impact haptic effect on iOS.
 * @member MobileUtils_VIBRATE_KIND_IOS_IMPACT_MEDIUM A medium impact haptic effect on iOS.
 * @member MobileUtils_VIBRATE_KIND_IOS_IMPACT_HEAVY A heavy impact haptic effect on iOS.
 * @member MobileUtils_VIBRATE_KIND_IOS_IMPACT_RIGID A rigid impact haptic effect on iOS. This is only available on iOS >= 13.
 * @member MobileUtils_VIBRATE_KIND_IOS_IMPACT_SOFT A soft impact haptic effect on iOS. This is only available on iOS >= 13.
 * @member MobileUtils_VIBRATE_KIND_IOS_SELECTION A selection haptic effect on iOS.
 * @member MobileUtils_VIBRATE_KIND_IOS_NOTIFICATION_WARNING A warning notification haptic effect on iOS.
 * @member MobileUtils_VIBRATE_KIND_IOS_NOTIFICATION_SUCCESS A success notification haptic effect on iOS.
 * @member MobileUtils_VIBRATE_KIND_IOS_NOTIFICATION_ERROR An error notification haptic effect on iOS.
 * @constant_end
 */

// Modules

/**
 * @module vibration
 * @title Device Vibration
 * @desc This module contains functions to interact with device vibration on the Android, iOS and HTML5 platforms.
 * 
 * @section_func Functions
 * @desc The following functions can be used:
 * @ref MobileUtils_Vibrate_Shot
 * @ref MobileUtils_Vibrate_Predefined
 * @ref MobileUtils_Vibrate_Is_Available
 * @section_end
 * 
 * @section_const Constants
 * @desc These are the constants that you can use:
 * @ref MobileUtils_VIBRATE_KIND
 * @section_end
 * 
 * @module_end
 */
