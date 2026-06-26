
mobile_utils_gallery_open(
    function(_success, _path, _filename, _error)
    {
        if (!_success)
        {
            show_debug_message("Gallery failed: " + _error);
            return;
        }

        show_debug_message($"Path: {_path}");
        show_debug_message($"Filename: {_filename}");

        scr_image_tools_square_crop(_path, 300);

        Obj_MobileUtils_Gallery_Picture.sprite =
            sprite_add(
                _path,
                1,
                false,
                false,
                150,
                150
            );

        // The sprite has already loaded the image into memory,
        // so the temporary copied file can be deleted.
        if (file_exists(_path))
        {
            file_delete(_path);
        }
    }
);

