
event_inherited();

draw_set_valign(fa_top)
draw_set_halign(fa_left)

var _read = "android.permission.READ_EXTERNAL_STORAGE"
var _write = "android.permission.WRITE_EXTERNAL_STORAGE"
var _camara = "android.permission.CAMERA"

if(!os_check_permission(_write) and !os_check_permission(_read))
	draw_text(50,100,"Read/Write Permission: NULL")
else
	draw_text(50,100,"Read/Write Permission: OK")
	
if(!os_check_permission(_camara))
	draw_text(50,130,"CAMERA Permission: NULL")
else
	draw_text(50,130,"CAMERA Permission: OK")
