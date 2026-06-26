
var _str = ""

switch(mobile_utils_night_mode_check())
{
	case MobileUtilsNightMode.Dark:
		_str = "Dark"
	break
	
	case MobileUtilsNightMode.Light:
		_str = "Light"
	break
	
	case MobileUtilsNightMode.Undefined:
		_str = "Undefined"
	break
}

draw_set_valign(fa_top)
draw_set_halign(fa_left)

draw_text(x,y,_str + " Mode")