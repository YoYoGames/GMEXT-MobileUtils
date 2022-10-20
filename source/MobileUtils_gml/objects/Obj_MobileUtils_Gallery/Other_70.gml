
if(async_load[?"type"] == "MobileUtils_Gallery_Open")
{
	var _path = async_load[?"path"]
	
	scr_image_tools_square_crop(_path,300)
		
	Obj_MobileUtils_Gallery_Picture.sprite = sprite_add(_path,0,0,0,150,150)
}

