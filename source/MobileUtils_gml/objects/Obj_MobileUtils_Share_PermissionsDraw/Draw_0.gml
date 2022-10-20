draw_set_valign(fa_top)
draw_set_halign(fa_left)

var _read = "android.permission.READ_EXTERNAL_STORAGE"
var _write = "android.permission.WRITE_EXTERNAL_STORAGE"

if(!os_check_permission(_write) and !os_check_permission(_read))
	draw_text(50,100,"read/write Permission: NULL")
else
	draw_text(50,130,"read/write Permission: OK")
