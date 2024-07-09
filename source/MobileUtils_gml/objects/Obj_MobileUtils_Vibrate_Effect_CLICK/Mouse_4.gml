
var perm = "android.permission.VIBRATE"

if(os_type == os_android)
if(os_check_permission(perm))
{
	MobileUtils_Android_Vibrate_Predefined(MobileUtils_Android_Vibrate_EFFECT_CLICK)
}
else
{
	os_request_permission(perm)
}
