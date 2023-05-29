
var str = ""
switch(MobileUtils_NightMode_Check())
{
	case MobileUtils_NightMode_Night:
		str = "Night"
	break
	
	case MobileUtils_NightMode_Light:
		str = "Light"
	break
	
	case MobileUtils_NightMode_Undefined:
		str = "Undefined"
	break
}

draw_set_valign(fa_left)
draw_set_halign(fa_left)

draw_text(x,y,str + " Mode")