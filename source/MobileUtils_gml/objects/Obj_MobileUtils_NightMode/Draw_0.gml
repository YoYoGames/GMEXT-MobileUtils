
var _str = ""
switch(MobileUtils_NightMode_Check())
{
	case MobileUtils_NightMode_Night:
		_str = "Night"
	break
	
	case MobileUtils_NightMode_Light:
		_str = "Light"
	break
	
	case MobileUtils_NightMode_Undefined:
		_str = "Undefined"
	break
}

draw_set_valign(fa_top)
draw_set_halign(fa_left)

draw_text(x,y,_str + " Mode")