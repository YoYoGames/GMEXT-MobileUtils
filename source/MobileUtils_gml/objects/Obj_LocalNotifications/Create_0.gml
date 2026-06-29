/// @description Initialize variables

if(!persistent){
	show_message_async("Usually in your game Obj_LocalNotifications should be persistent and set in your first room")
}

if (instance_number(object_index) > 1) {
	// Destroy if there is more than one created
	instance_destroy();
	return;
}

// Keeps track of the current notification permission status (a
// MobileUtilsNotificationPermission value). Used by the Draw event.
permission_status = MobileUtilsNotificationPermission.NotDetermined;

// Register a single listener that is invoked every time a local notification is
// presented (foreground) or tapped. This replaces the old Async events: the
// notification fields are now delivered straight to this callback.
mobile_utils_notification_set_listener(function(_id, _title, _message, _data, _image_path)
{
	show_debug_message("notification_id: " + _id);
	show_debug_message("notification_title: " + _title);
	show_debug_message("notification_message: " + _message);
	show_debug_message("notification_data: " + _data);
	show_debug_message("notification_image_path: " + _image_path);
});

// Before delivering notifications we need permission. We first query the current
// status; the result is delivered through the callback (no Async event needed).
// On iOS this maps to UNUserNotificationCenter; on Android to POST_NOTIFICATIONS.
mobile_utils_notification_permission_status(function(_status)
{
	permission_status = _status;

	switch(_status)
	{
		case MobileUtilsNotificationPermission.Authorized:
			// Authorized to deliver notifications to the user.
			break;

		case MobileUtilsNotificationPermission.Denied:
			// Permission to deliver notifications was denied.
			break;

		case MobileUtilsNotificationPermission.NotDetermined:
			// Permission hasn't been requested yet, so request it now. The
			// callback reports whether the user granted it.
			mobile_utils_notification_request_permission(function(_granted, _error)
			{
				permission_status = _granted
					? MobileUtilsNotificationPermission.Authorized
					: MobileUtilsNotificationPermission.Denied;

				if(_error != "")
					show_debug_message("Notification permission error: " + _error);
			});
			break;
	}
});
