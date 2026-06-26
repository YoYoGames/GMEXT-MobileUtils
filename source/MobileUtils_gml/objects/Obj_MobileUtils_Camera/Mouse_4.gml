
var _read = "android.permission.READ_EXTERNAL_STORAGE"
var _write = "android.permission.WRITE_EXTERNAL_STORAGE"
var _camara = "android.permission.CAMERA"

if(os_type == os_ios or os_check_permission(_write) and os_check_permission(_read) and os_check_permission(_camara))
{
    MobileUtils_Camera_Open()
}
else
{
	if(!os_check_permission(_write) and !os_check_permission(_read))
		os_request_permission(_write, _read)
	
	if(!os_check_permission(_camara))
		os_request_permission(_camara)
}
