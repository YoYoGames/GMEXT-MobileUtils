
show_debug_message("Async: " + json_encode(async_load))

if(async_load[?"type"] == "MobileUtils_Camera_Open")
{
	if(!async_load[?"success"])
		exit
	var _path = async_load[?"path"]
	
	scr_image_tools_square_crop(_path,300)
	
	Obj_MobileUtils_Camera_Picture.sprite = sprite_add(_path,0,0,0,150,150)
}
