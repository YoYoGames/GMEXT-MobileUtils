
var perm = "android.permission.VIBRATE"

if(os_type == os_android)
if(os_check_permission(perm))
{
    MobileUtils_Android_Vibrate_Shot(1000,255)
}
else
{
	os_request_permission(perm)
}
