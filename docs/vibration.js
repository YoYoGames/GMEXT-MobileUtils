
// FUNCTIONS

/**
 * @function mobile_utils_vibrate_is_available
 * @desc This function reports what level of vibration / haptic support the device has.
 *
 * The returned value is a member of the ${constant.MobileUtilsVibrationAvailability} enumeration. Call this before triggering a vibration to decide whether it will have any effect.
 *
 * [[Note: `HapticEngine` is only ever returned on iOS (devices with a Core Haptics engine). Android reports either `None` or `Basic`.]]
 *
 * @returns {Real} The device's vibration capability
 *
 * @example
 * ```gml
 * if (mobile_utils_vibrate_is_available() == MobileUtilsVibrationAvailability.None)
 * {
 *     show_debug_message("Vibration is not available.");
 * }
 * ```
 * The code above checks whether the device can vibrate at all.
 * @function_end
 */

/**
 * @function mobile_utils_vibrate_predefined
 * @desc This function plays one of the device's predefined haptic effects.
 *
 * The `kind` is a value from the platform-specific enumeration for the device you are running on: use a ${constant.MobileUtilsAndroidVibrationKind} member on Android and a ${constant.MobileUtilsIOSVibrationKind} member on iOS. Branch on `os_type` to choose the correct one.
 *
 * [[Warning: The two enumerations share the same low integers with different meanings (for example `2` is `Tick` on Android but `ImpactHeavy` on iOS), and some values exist on only one platform. Never pass a raw integer or an Android kind on iOS (or vice versa) — always use the enum member that matches the running platform, otherwise you get the wrong effect or a `false` return.]]
 *
 * @param {Real} kind The predefined effect to play — a ${constant.MobileUtilsAndroidVibrationKind} member on Android or a ${constant.MobileUtilsIOSVibrationKind} member on iOS
 * @returns {Bool} `true` if the effect was played, `false` if the device cannot play it or the kind is not valid for the platform
 *
 * @example
 * ```gml
 * if (mobile_utils_vibrate_is_available())
 * {
 *     var _kind = (os_type == os_ios)
 *         ? MobileUtilsIOSVibrationKind.ImpactMedium
 *         : MobileUtilsAndroidVibrationKind.Click;
 *     mobile_utils_vibrate_predefined(_kind);
 * }
 * ```
 * The code above plays a predefined haptic using the enum member appropriate to the current platform.
 * @function_end
 */

/**
 * @function mobile_utils_vibrate_shot
 * @desc This function plays a single vibration of the given duration.
 *
 * On iOS 13 and later this is a continuous Core Haptics event of the requested length; on older iOS it falls back to a predefined impact. On Android it is a one-shot vibration of the requested duration.
 *
 * @param {Real} milliseconds The vibration duration in milliseconds (must be greater than 0)
 * @returns {Bool} `true` if the vibration was played, `false` on an invalid duration or an incapable device
 *
 * @example
 * ```gml
 * if (mobile_utils_vibrate_is_available())
 * {
 *     mobile_utils_vibrate_shot(1000);
 * }
 * ```
 * The code above plays a one-second vibration when the device supports it.
 * @function_end
 */

// CONSTANTS

/**
 * @const MobileUtilsVibrationAvailability
 * @desc This enumeration contains the vibration capability levels returned by ${function.mobile_utils_vibrate_is_available}.
 * @member None The device has no vibration hardware.
 * @member Basic The device supports basic vibration.
 * @member HapticEngine The device has a dedicated haptic engine (iOS only).
 * @const_end
 */

/**
 * @const MobileUtilsAndroidVibrationKind
 * @desc This enumeration contains the predefined haptic effects available on **Android**, for use with ${function.mobile_utils_vibrate_predefined}.
 * @member Click A single click effect.
 * @member DoubleClick A double click effect.
 * @member Tick A light tick effect.
 * @member HeavyClick A heavy click effect.
 * @const_end
 */

/**
 * @const MobileUtilsIOSVibrationKind
 * @desc This enumeration contains the predefined haptic effects available on **iOS**, for use with ${function.mobile_utils_vibrate_predefined}.
 * @member ImpactLight A light impact feedback.
 * @member ImpactMedium A medium impact feedback.
 * @member ImpactHeavy A heavy impact feedback.
 * @member ImpactRigid A rigid impact feedback (iOS 13+).
 * @member ImpactSoft A soft impact feedback (iOS 13+).
 * @member Selection A selection-changed feedback.
 * @member NotificationWarning A warning notification feedback.
 * @member NotificationSuccess A success notification feedback.
 * @member NotificationError An error notification feedback.
 * @const_end
 */

// MODULES

/**
 * @module vibration
 * @title Device Vibration
 * @desc This module triggers device vibration and haptic feedback on **Android** and **iOS**.
 *
 * The predefined effects use platform-specific enumerations that overlap numerically — always select the effect with the enum member that matches the running platform (see ${function.mobile_utils_vibrate_predefined}).
 *
 * @section_func
 * @desc The following functions are provided to work with vibration:
 * @ref mobile_utils_vibrate_is_available
 * @ref mobile_utils_vibrate_predefined
 * @ref mobile_utils_vibrate_shot
 * @section_end
 *
 * @section_const
 * @desc The following constants are used by this module:
 * @ref MobileUtilsVibrationAvailability
 * @ref MobileUtilsAndroidVibrationKind
 * @ref MobileUtilsIOSVibrationKind
 * @section_end
 *
 * @module_end
 */
