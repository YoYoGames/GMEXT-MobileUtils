
function scr_image_tools_square_crop(_path,_size)
{
	var _w = MobileUtils_Image_Width(_path);
	var _h = MobileUtils_Image_Height(_path);
	
	if(_w > _h) MobileUtils_Image_Crop(_path, _h, _h, (_w - _h)/2, 0);
	if(_w < _h) MobileUtils_Image_Crop(_path, _w, _w, 0, (_h - _w)/2);
	
	
	MobileUtils_Image_Resize(_path,_size,_size);
}
