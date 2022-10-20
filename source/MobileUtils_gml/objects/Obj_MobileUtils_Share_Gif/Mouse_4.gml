
var _file = "SharedGif.gif"
file_copy("YYGif.gif", _file);

var _read = "android.permission.READ_EXTERNAL_STORAGE"
var _write = "android.permission.WRITE_EXTERNAL_STORAGE"
if (os_check_permission(_write) and os_check_permission(_read))
	MobileUtils_Share_Open("Title!","image/gif", _file)
else
	os_request_permission(_write, _read)
