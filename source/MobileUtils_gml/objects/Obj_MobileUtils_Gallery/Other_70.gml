
if(async_load[?"type"] == "MobileUtils_Gallery_Open")
{
	var _path = async_load[?"path"]
	show_debug_message($"Path: {_path}")
	
	scr_image_tools_square_crop(_path,300)
		
	Obj_MobileUtils_Gallery_Picture.sprite = sprite_add(_path,0,0,0,150,150)
	
	file_delete(_path)//let's delete the file (most of times we don't need it)
}

