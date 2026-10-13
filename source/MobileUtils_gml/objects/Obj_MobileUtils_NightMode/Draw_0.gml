
var _str = ""

switch(night_mode_check())
{
	case NightMode.Dark:
		_str = "Dark"
	break
	
	case NightMode.Light:
		_str = "Light"
	break
	
	case NightMode.Undefined:
		_str = "Undefined"
	break
}

draw_set_valign(fa_top)
draw_set_halign(fa_left)

draw_text(x,y,_str + " Mode")