
function scr_image_tools_square_crop(_path,_size)
{
	
	var _w = image_width(_path);
	var _h = image_height(_path);
	
	if(_w > _h) image_crop(_path, _h, _h, (_w - _h)/2, 0);
	image_crop(_path, _w, _w, 0, (_h - _w)/2);
	
	
	image_resize(_path,_size,_size);
}
