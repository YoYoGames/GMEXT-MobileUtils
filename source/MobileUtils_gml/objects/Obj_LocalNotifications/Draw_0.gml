/// @description Draw permission

if(os_type == os_ios || os_type == os_android)
{
	// Map the MobileUtilsNotificationPermission value to a readable name.
	var _names = ["Unknown", "NotDetermined", "Denied", "Authorized", "Provisional", "Ephemeral"];
	var _name = (permission_status >= 0 && permission_status < array_length(_names))
		? _names[permission_status]
		: string(permission_status);

	draw_set_font(fnt_gm_15)
	draw_set_valign(fa_left)
	draw_set_halign(fa_left)
	draw_text(50,100,"notification_permission: " + _name)
}
