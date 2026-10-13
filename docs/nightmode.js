
// FUNCTIONS

/**
 * @function night_mode_check
 * @desc This function returns the device's current interface style (light or dark / night mode).
 *
 * The returned value is a member of the ${constant.NightMode} enumeration.
 *
 * @returns {Real} The current night-mode state
 *
 * @example
 * ```gml
 * switch (night_mode_check())
 * {
 *     case NightMode.Dark:      _str = "Dark";      break;
 *     case NightMode.Light:     _str = "Light";     break;
 *     case NightMode.Undefined: _str = "Undefined"; break;
 * }
 * draw_text(x, y, _str + " Mode");
 * ```
 * The code above reads the current night-mode state and draws it on screen.
 * @function_end
 */

// CONSTANTS

/**
 * @const NightMode
 * @desc This enumeration contains the possible interface styles returned by ${function.night_mode_check}.
 * @member Dark The device is in dark (night) mode.
 * @member Light The device is in light mode.
 * @member Undefined The interface style could not be determined.
 * @const_end
 */

// MODULES

/**
 * @module nightmode
 * @title Night Mode
 * @desc This module reports whether the device is using light or dark (night) mode on **Android** and **iOS**.
 *
 * @section_func
 * @desc The following function is provided:
 * @ref night_mode_check
 * @section_end
 *
 * @section_const
 * @desc The following constant is used by this module:
 * @ref NightMode
 * @section_end
 *
 * @module_end
 */
