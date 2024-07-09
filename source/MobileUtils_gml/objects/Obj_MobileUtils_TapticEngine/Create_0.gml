
if(os_type == os_ios)
switch(MobileUtils_TapticEngine_Is_Supported())
{
	case 2:
	    // 2 means the device has a Taptic Engine
		
	break
	
	case 1:
		// 1 means no Taptic Engine, but will support AudioToolbox
		show_message_async("Taptic Engine UNSUPPORTED")
	break
		
	default:
	    // 0
	    // No haptic support
	    // Do something else, like a beeping noise or LED flash instead of haptics
		show_message_async("Taptic Engine UNSUPPORTED")
	break
}
