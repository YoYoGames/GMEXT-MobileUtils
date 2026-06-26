
function scr_image_tools_square_crop(_path,_size)
{
	
	var _w = mobile_utils_image_width(_path);
	var _h = mobile_utils_image_height(_path);
	
	if(_w > _h) mobile_utils_image_crop(_path, _h, _h, (_w - _h)/2, 0);
	mobile_utils_image_crop(_path, _w, _w, 0, (_h - _w)/2);
	
	
	mobile_utils_image_resize(_path,_size,_size);
}
