/// @description Create notification Android

// Same as mobile_utils_notification_create but also takes an image path that is
// shown as the notification's large icon (Android). On iOS the image is ignored.
mobile_utils_notification_create_ext(uid, seconds, title, msg, data, filename);

show_debug_message("Notification Created (with icon): " + uid)
