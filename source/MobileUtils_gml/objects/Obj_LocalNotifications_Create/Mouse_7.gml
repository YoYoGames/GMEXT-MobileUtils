/// @description Create notification

// Registers a new local notification to be delivered some time in the future.
// The function returns nothing; when the notification fires/is tapped it is
// reported through the listener registered in Obj_LocalNotifications
// (mobile_utils_notification_set_listener).
mobile_utils_notification_create(uid, seconds, title, msg, data);

show_debug_message("Notification Created: " + uid)
