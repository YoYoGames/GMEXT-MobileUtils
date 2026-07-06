
// FUNCTIONS

/**
 * @function mobile_utils_notification_create
 * @desc This function schedules a local notification to be shown after a delay.
 *
 * The notification fires `seconds` from now, showing `title` and `message`. The `data` string is an arbitrary payload that is delivered back to your listener when the notification is presented or tapped (see ${function.mobile_utils_notification_set_listener}). Scheduling a new notification with an `identifier` that is already pending replaces the previous one.
 *
 * [[Note: If `seconds` is `0` or negative the call does nothing. Notification permission must be granted for the notification to appear (see ${function.mobile_utils_notification_request_permission}).]]
 *
 * @param {String} identifier A unique identifier for this notification (used to cancel or replace it)
 * @param {Real} seconds The delay before the notification fires, in seconds (must be greater than 0)
 * @param {String} title The notification title
 * @param {String} message The notification body text
 * @param {String} data An arbitrary payload string delivered back through the listener
 *
 * @example
 * ```gml
 * mobile_utils_notification_create("daily_reminder", 5, "Come back!", "Your energy is full.", "reminder");
 * ```
 * The code above schedules a notification to appear five seconds from now.
 * @function_end
 */

/**
 * @function mobile_utils_notification_create_ext
 * @desc This function schedules a local notification with an image, extending ${function.mobile_utils_notification_create}.
 *
 * It behaves exactly like ${function.mobile_utils_notification_create} but also takes an `image_path`. On Android the image is shown as the notification's large icon; on iOS it is attached to the notification. The path is used as-is if absolute, otherwise it is resolved relative to the application's storage area; if the file cannot be used, the notification is still scheduled without the image.
 *
 * @param {String} identifier A unique identifier for this notification (used to cancel or replace it)
 * @param {Real} seconds The delay before the notification fires, in seconds (must be greater than 0)
 * @param {String} title The notification title
 * @param {String} message The notification body text
 * @param {String} data An arbitrary payload string delivered back through the listener
 * @param {String} image_path The path to an image to show with the notification
 *
 * @example
 * ```gml
 * // Save a sprite to disk, then schedule a notification that shows it.
 * var _file = "notification_icon.png";
 * sprite_save(spr_icon, 0, _file);
 * mobile_utils_notification_create_ext("with_icon", 5, "Large Icon!", "Nice, right?", "", _file);
 * ```
 * The code above schedules a notification that displays an image.
 * @function_end
 */

/**
 * @function mobile_utils_notification_cancel
 * @desc This function cancels a pending local notification that was scheduled with ${function.mobile_utils_notification_create} or ${function.mobile_utils_notification_create_ext}.
 *
 * If no notification with the given identifier is pending, the call has no effect.
 *
 * @param {String} identifier The identifier of the notification to cancel
 *
 * @example
 * ```gml
 * mobile_utils_notification_cancel("daily_reminder");
 * ```
 * The code above cancels a previously scheduled notification.
 * @function_end
 */

/**
 * @function mobile_utils_notification_set_listener
 * @desc This function registers a listener that is called whenever a local notification is presented (while the app is in the foreground) or tapped by the player.
 *
 * The listener stays registered and may be invoked many times. Notifications that arrive before a listener is registered — for example a tap that cold-starts the app — are queued and delivered as soon as the listener is set.
 *
 * [[Note: The `image_path` member is only populated on Android; on iOS it is always an empty string.]]
 *
 * @param {Function} callback The listener method to call for each presented or tapped notification
 *
 * @event callback
 * @desc This callback is triggered each time a local notification is presented or tapped.
 * @member {String} identifier The identifier of the notification
 * @member {String} title The notification title
 * @member {String} message The notification body text
 * @member {String} data The payload string that was supplied when the notification was created
 * @member {String} image_path The image path associated with the notification (Android only; always empty on iOS)
 * @event_end
 *
 * @example
 * ```gml
 * mobile_utils_notification_set_listener(function(_id, _title, _message, _data, _image_path)
 * {
 *     show_debug_message($"Notification '{_id}' fired: {_title} - {_message}");
 * });
 * ```
 * The code above registers a listener that logs every notification as it is presented or tapped.
 * @function_end
 */

/**
 * @function mobile_utils_notification_request_permission
 * @desc This function requests permission to show notifications, prompting the player if required.
 *
 * On Android 13+ this triggers the runtime `POST_NOTIFICATIONS` prompt; on iOS it requests notification authorization. On platforms/versions with no runtime prompt it reports the current effective setting.
 *
 * @param {Function} callback The method to call once the permission request resolves
 *
 * @event callback
 * @desc This callback is triggered when the permission request resolves.
 * @member {Bool} granted Whether notification permission is granted
 * @member {String} error The error message (empty when `granted` is `true`)
 * @event_end
 *
 * @example
 * ```gml
 * mobile_utils_notification_request_permission(function(_granted, _error)
 * {
 *     if (!_granted) show_debug_message("Notifications not granted: " + _error);
 * });
 * ```
 * The code above requests notification permission and logs the outcome.
 * @function_end
 */

/**
 * @function mobile_utils_notification_permission_status
 * @desc This function queries the current notification permission status without prompting the player.
 *
 * The status passed to the callback is a member of the ${constant.MobileUtilsNotificationPermission} enumeration.
 *
 * [[Note: `Provisional` and `Ephemeral` are only ever reported on iOS.]]
 *
 * @param {Function} callback The method to call with the current permission status
 *
 * @event callback
 * @desc This callback is triggered with the current notification permission status.
 * @member {Constant.MobileUtilsNotificationPermission} status The current notification permission status
 * @event_end
 *
 * @example
 * ```gml
 * mobile_utils_notification_permission_status(function(_status)
 * {
 *     if (_status == MobileUtilsNotificationPermission.NotDetermined)
 *     {
 *         mobile_utils_notification_request_permission(function(_granted, _error) {});
 *     }
 * });
 * ```
 * The code above checks the notification permission and requests it only if it has not been decided yet.
 * @function_end
 */

// CONSTANTS

/**
 * @const MobileUtilsNotificationPermission
 * @desc This enumeration contains the possible notification permission states reported by ${function.mobile_utils_notification_permission_status} (and used with ${function.mobile_utils_notification_request_permission}).
 * @member Unknown The permission state could not be determined.
 * @member NotDetermined The player has not yet been asked for permission.
 * @member Denied Notifications are not permitted.
 * @member Authorized Notifications are permitted.
 * @member Provisional Notifications are provisionally authorized (iOS only).
 * @member Ephemeral Notifications are ephemerally authorized, e.g. for an App Clip (iOS only).
 * @const_end
 */

// MODULES

/**
 * @module local_notifications
 * @title Local Notifications
 * @desc This module schedules, cancels and listens for local notifications, and manages notification permission, on **Android** and **iOS**.
 *
 * @section_func
 * @desc The following functions are provided to work with local notifications:
 * @ref mobile_utils_notification_create
 * @ref mobile_utils_notification_create_ext
 * @ref mobile_utils_notification_cancel
 * @ref mobile_utils_notification_set_listener
 * @ref mobile_utils_notification_request_permission
 * @ref mobile_utils_notification_permission_status
 * @section_end
 *
 * @section_const
 * @desc The following constant is used by this module:
 * @ref MobileUtilsNotificationPermission
 * @section_end
 *
 * @module_end
 */
