// Functions

/**
 * @function MobileUtils_Android_Vibrate_Shot
 * @desc This function creates a one-shot vibration.
 * 
 * A one-shot vibration will vibrate constantly for the specified period of time at the specified amplitude, and then stop.
 * 
 * @param {real} milliseconds The number of milliseconds to vibrate
 * @param {real} amplitude The amplitude of the vibration. This is a value between 1 and 255, or -1 for the default
 * 
 * @example
 * ```gml
 * if (os_type != os_android) { exit; }
 * 
 * var _perm_vibrate = "android.permission.VIBRATE";
 * if (os_check_permission(_perm_vibrate))
 * {
 *     MobileUtils_Android_Vibrate_Shot(1000, 255);
 * } else
 * {
 *     os_request_permission(_perm_vibrate);
 * }
 * ```
 * The code example above first checks if the ${var.os_type} is `os_android` and if it's not, exits the block of code.
 * It then checks if the permission `"android.permission.VIBRATE"` is granted. If it is, a one-shot vibration of 1 second is created, with a maximal amplitude of 255.
 * If the permission hasn't been granted, it is requested with a call to ${function.os_request_permission}.
 * @function_end
 */

/**
 * @function MobileUtils_Android_Vibrate_Predefined
 * @desc This function creates a predefined vibration effect.
 * 
 * @param {constant.MobileUtils_Android_Vibrate_EFFECT} effectId The predefined effect to create
 * 
 * @example
 * ```gml
 * if (os_type != os_android) { exit; }
 * 
 * var _perm_vibrate = "android.permission.VIBRATE";
 * if (os_check_permission(_perm_vibrate))
 * {
 *     MobileUtils_Android_Vibrate_Predefined(MobileUtils_Android_Vibrate_EFFECT_HEAVY_CLICK);
 * } else
 * {
 *     os_request_permission(_perm_vibrate);
 * }
 * ```
 * @function_end
 */

/**
 * @function MobileUtils_Android_Vibrate_Available
 * @desc This function returns if device vibration is available.
 * 
 * @example
 * ```gml
 * if (MobileUtils_Android_Vibrate_Available())
 * {
 *     show_debug_message("This device supports vibration.");
 * }
 * ```
 * @function_end
 */

/**
 * @function MobileUtils_TapticEngine_Is_Supported
 * @desc This function returns whether Taptic Engine is supported.
 * 
 * @returns {boolean}
 * 
 * @function_end
 */

/**
 * @function MobileUtils_TapticEngine_Vibrate
 * @desc This function vibrates the device using Taptic Engine.
 * 
 * @param {constant.TAPTIC_ENGINE_KIND} kind The kind of effect to create
 * 
 * @function_end
 */

/**
 * @function MobileUtils_Web_Vibrate_Available
 * @desc This function returns whether web vibrate is available.
 * 
 * @returns {boolean}
 * 
 * @example
 * ```gml
 * if MobileUtils_Web_Vibrate_Available()
 * {
 *     MobileUtils_Web_Vibrate_Shot(400);
 * }
 * ```
 * @function_end
 */

/**
 * @function MobileUtils_Web_Vibrate_Shot
 * @desc This function vibrates the device for a given number of milliseconds.
 * 
 * @example
 * ```gml
 * if MobileUtils_Web_Vibrate_Available()
 * {
 *     MobileUtils_Web_Vibrate_Shot(400);
 * }
 * ```
 * @function_end
 */

// Constants

/**
 * @constant MobileUtils_Android_Vibrate_EFFECT
 * @desc This set of constants represents the predefined vibration effects that can be used.
 * @member MobileUtils_Android_Vibrate_EFFECT_CLICK A click effect.
 * @member MobileUtils_Android_Vibrate_EFFECT_DOUBLE_CLICK A double click effect.
 * @member MobileUtils_Android_Vibrate_EFFECT_HEAVY_CLICK A heavy click effect.
 * @member MobileUtils_Android_Vibrate_EFFECT_TICK A tick effect.
 * @constant_end
 */

/**
 * @constant TAPTIC_ENGINE_KIND
 * @desc This set of constants represents the predefined vibration effects to be used with Taptic Engine.
 * @member TAPTIC_ENGINE_IMPACT_LIGHT
 * @member TAPTIC_ENGINE_IMPACT_MEDIUM
 * @member TAPTIC_ENGINE_IMPACT_HEAVY
 * @member TAPTIC_ENGINE_IMPACT_RIGID
 * @member TAPTIC_ENGINE_IMPACT_SOFT
 * @member TAPTIC_ENGINE_SELECTION
 * @member TAPTIC_ENGINE_NOTIFICATION_WARNING
 * @member TAPTIC_ENGINE_NOTIFICATION_SUCCESS
 * @member TAPTIC_ENGINE_NOTIFICATION_ERROR
 * @constant_end
 */

// Modules

/**
 * @module vibration
 * @title Device Vibration
 * @desc This module contains functions to interact with device vibration.
 * 
 * @section_func Android Functions
 * @desc The following functions can be used on Android:
 * @ref MobileUtils_Android_Vibrate_Shot
 * @ref MobileUtils_Android_Vibrate_Predefined
 * @ref MobileUtils_Android_Vibrate_Available
 * @section_end
 * 
 * @section_func Taptic Engine (iOS)
 * @desc The following functions can be used on iOS:
 * @ref MobileUtils_TapticEngine_Is_Supported
 * @ref MobileUtils_TapticEngine_Vibrate
 * @section_end
 * 
 * @section_func Web Vibrate (HTML5)
 * @desc The following functions can be used on web:
 * @ref MobileUtils_Web_Vibrate_Available
 * @ref MobileUtils_Web_Vibrate_Shot
 * @section_end
 * 
 * @section_const Constants
 * @desc These are the constants that you can use:
 * @ref MobileUtils_Android_Vibrate_EFFECT
 * @ref TAPTIC_ENGINE_KIND
 * @section_end
 * 
 * @module_end
 */
