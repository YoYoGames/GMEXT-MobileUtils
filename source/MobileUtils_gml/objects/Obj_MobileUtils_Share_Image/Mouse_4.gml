
var _file = "mSharedImage.gif"
file_copy("YYImage.jpg",_file)

var _read = "android.permission.READ_EXTERNAL_STORAGE"
var _write = "android.permission.WRITE_EXTERNAL_STORAGE"
if(os_check_permission(_write) and os_check_permission(_read))
	MobileUtils_Share_Open("Title!","image/jpg",_file)
else
	os_request_permission(_write,_read)
