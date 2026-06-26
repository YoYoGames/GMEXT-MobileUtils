
if (os_type == os_ios)
{
    mobile_utils_camera_open(
        function(_success, _path, _error)
        {
            if (!_success)
            {
                show_debug_message("Camera failed: " + _error);
                return;
            }

            show_debug_message("Camera image path: " + _path);

            scr_image_tools_square_crop(_path, 300);

            // Delete the previous runtime sprite when appropriate.
            // sprite_delete(Obj_MobileUtils_Camera_Picture.sprite);

            Obj_MobileUtils_Camera_Picture.sprite =sprite_add(_path,1,false,false,150,150);
        }
    );

    exit;
}


// Android

var _camera_permission = "android.permission.CAMERA";

if (os_check_permission(_camera_permission))
{
    mobile_utils_camera_open(
        function(_success, _path, _error)
        {
            if (!_success)
            {
                show_debug_message("Camera failed: " + _error);
                return;
            }

            show_debug_message("Camera image path: " + _path);

            scr_image_tools_square_crop(_path, 300);

            Obj_MobileUtils_Camera_Picture.sprite = sprite_add(_path,1,false,false,150,150);
        }
    );
}
else
{
    os_request_permission(_camera_permission);
}

