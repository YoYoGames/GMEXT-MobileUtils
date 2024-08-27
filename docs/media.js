// Functions

/**
 * @func MobileUtils_Camera_Open
 * @desc This function brings up the camera to take a picture.
 * 
 * [[NOTE: On iOS devices, permissions will be requested automatically. Android developers already have the required permissions added to the manifest by the extension:  `android.permission.READ_EXTERNAL_STORAGE`, `android.permission.WRITE_EXTERNAL_STORAGE`, `android.permission.CAMERA`.]]
 * 
 * @event social
 * @member {string} type The string `"MobileUtils_Camera_Open"`
 * @member {string} path The path to the photo
 * @member {boolean} success Whether successful
 * @event_end
 * 
 * @example
 * ```gml
 * var _read = "android.permission.READ_EXTERNAL_STORAGE";
 * var _write = "android.permission.WRITE_EXTERNAL_STORAGE";
 * var _camera = "android.permission.CAMERA";
 * 
 * if(os_type == os_ios or os_check_permission(_write) and os_check_permission(_read) and os_check_permission(_camera))
 * {
 *     MobileUtils_Camera_Open();
 * }
 * else
 * {
 *     if(!os_check_permission(_write) and !os_check_permission(_read))
 *         os_request_permission(_write, _read);
 * 
 *     if(!os_check_permission(_camera))
 *         os_request_permission(_camera);
 * }
 * ```
 * The code sample above triggers the mobile device camera overlay that will allow users to take a photo. This photo path can be later caught inside a ${event.social}.
 * 
 * ```gml
 * if(async_load[?"type"] == "MobileUtils_Camera_Open")
 * {
 *     var _path = async_load[?"path"];
 *     Obj_MobileUtils_Camera_Picture.sprite = sprite_add(_path, 0, 0, 0, 0, 0);    
 * }
 * ```
 * The code above matches the response against the correct event **type** and loads the newly taken photo.
 * @function_end
 */

/**
 * @func MobileUtils_Gallery_Open
 * @desc This function opens the gallery to select a photo.
 * 
 * @event social
 * @member {string} type The string `"MobileUtils_Gallery_Open"`
 * @member {string} path The path to the image
 * @event_end
 * 
 * @example
 * ```gml
 * MobileUtils_Gallery_Open();
 * ```
 * The code sample above triggers the mobile device gallery overlay, allowing the user to select a photo, this will later trigger a ${event.social}.
 * 
 * ```gml
 * if(async_load[?"type"] == "MobileUtils_Gallery_Open")
 * {
 *     var _path = async_load[?"path"];
 *     MobileUtils_Image_Resize(_path, 300, 300);
 *     MobileUtils_Image_Crop(_path, 100, 100, 100, 100);
 *     Obj_MobileUtils_Gallery_Picture.sprite = sprite_add(_path, 0, 0, 0, 0, 0);
 * }
 * ```
 * The code above matches the response against the correct event **type** and proceeds to resize, crop and load the sprite into a variable.
 * @function_end
 */

/**
 * @func MobileUtils_Image_Crop
 * @desc This function crops the image at the given file path to the given dimensions.
 * 
 * @param {string} path The path to the image
 * @param {real} w The width of the zone to crop
 * @param {real} h The height of the zone to crop
 * @param {real} x The x offset of the zone to crop
 * @param {real} y The y offset of the zone to crop
 * 
 * @example
 * ```gml
 * if(async_load[?"type"] == "MobileUtils_Gallery_Open")
 * {
 *     var _path = async_load[?"path"];
 *     if(MobileUtils_Image_Width(_path) != 300 or MobileUtils_Image_Height(_path) != 300)
 *     {
 *         MobileUtils_Image_Resize(_path, 300, 300);
 *         MobileUtils_Image_Crop(_path, 100, 100, 100, 100);
 *         MobileUtils_Image_Resize(_path, 300, 300);
 *     }
 *     Obj_MobileUtils_Gallery_Picture.sprite = sprite_add(_path, 0, 0, 0, 0, 0);
 * }
 * ```
 * The code above was extracted from the ${function.MobileUtils_Gallery_Open} sample and shows an example on how to crop an image (for a complete example please refer to the respective function).
 * @function_end
 */

/**
 * @func MobileUtils_Image_Height
 * @desc This function returns the height of an image.
 * 
 * @param {string} path The path to the image
 * 
 * @returns {real}
 * 
 * @example
 * ```gml
 * if(async_load[?"type"] == "MobileUtils_Gallery_Open")
 * {
 *     var _path = async_load[?"path"];
 *     if(MobileUtils_Image_Width(_path) != 300 or MobileUtils_Image_Height(_path) != 300)
 *     {
 *         MobileUtils_Image_Resize(_path, 300, 300);
 *         MobileUtils_Image_Crop(_path, 100, 100, 100, 100);
 *         MobileUtils_Image_Resize(_path, 300, 300);
 *     }
 *     Obj_MobileUtils_Gallery_Picture.sprite = sprite_add(_path, 0, 0, 0, 0, 0);
 * }
 * ```
 * The code above was extracted from the ${function.MobileUtils_Gallery_Open} sample and shows an example on how to get the height of an image (for a complete example please refer to the respective function).
 * @function_end
 */

/**
 * @func MobileUtils_Image_Resize
 * @desc This function resizes an image.
 * 
 * @param {string} path The path to the image
 * @param {real} width The width of the zone to crop
 * @param {real} height The height of the zone to crop
 * 
 * @example
 * ```gml
 * if(async_load[?"type"] == "MobileUtils_Gallery_Open")
 * {
 *     var _path = async_load[?"path"];
 *     if(MobileUtils_Image_Width(_path) != 300 or MobileUtils_Image_Height(_path) != 300)
 *     {
 *         MobileUtils_Image_Resize(_path, 300, 300);
 *         MobileUtils_Image_Crop(_path, 100, 100, 100, 100);
 *         MobileUtils_Image_Resize(_path, 300, 300);
 *     }
 *     Obj_MobileUtils_Gallery_Picture.sprite = sprite_add(_path, 0, 0, 0, 0, 0);
 * }
 * ```
 * The code above was extracted from the ${function.MobileUtils_Gallery_Open} sample and shows an example on how to resize an image (for a complete example please refer to the respective function).
 * @function_end
 */

/**
 * @func MobileUtils_Image_Width
 * @desc This function returns the width of an image.
 * 
 * @param {string} path The path to the image
 * 
 * @returns {real}
 * 
 * @example
 * ```gml
 * if(async_load[?"type"] == "MobileUtils_Gallery_Open")
 * {
 *     var _path = async_load[?"path"];
 *     if(MobileUtils_Image_Width(_path) != 300 or MobileUtils_Image_Height(_path) != 300)
 *     {
 *         MobileUtils_Image_Resize(_path, 300, 300);
 *         MobileUtils_Image_Crop(_path, 100, 100, 100, 100);
 *         MobileUtils_Image_Resize(_path, 300, 300);
 *     }
 *     Obj_MobileUtils_Gallery_Picture.sprite = sprite_add(_path, 0, 0, 0, 0, 0);
 * }
 * ```
 * The code above is was extracted from the ${function.MobileUtils_Gallery_Open} sample and shows an example on to get the width of an image (for a complete example please refer to the respective function).
 * @function_end
 */

/**
 * @func MobileUtils_Share_Open
 * @desc This function brings up a share popup.
 * 
 * [[NOTE: On iOS devices, permissions will be requested automatically. Android developers already have the required permissions added to the manifest by the extension: `android.permission.READ_EXTERNAL_STORAGE`, `android.permission.WRITE_EXTERNAL_STORAGE`, `android.permission.CAMERA`.]]
 * 
 * @param {string} title Title of the share (not available for all the providers)
 * @param {string} path The path to the file
 * @param {string} mime One of the following strings: `"text/plain"`, `"text/rtf"`, `"text/html"`, `"text/json"`, `"image/jpg"`, `"image/gif"`, `"application/pdf"`, `"*/*"`
 *
 * @example
 * ```gml
 * var _file = "mSharedImage.gif";
 * file_copy("YYImage.jpg", _file);
 * 
 * var _read = "android.permission.READ_EXTERNAL_STORAGE";
 * var _write = "android.permission.WRITE_EXTERNAL_STORAGE";
 * if(os_check_permission(_write) and os_check_permission(_read))
 * {
 *     MobileUtils_Share_Open("Title!", "image/jpg", _file);
 * }
 * else
 * {
 *     os_request_permission(_write, _read);
 * }
 * 
 * ```
 * The above code shows a code example.
 * @function_end
 */

 /**
  * @func MobileUtils_AppPopupSettings_Show
  * @desc This function brings up the app settings.
  * 
  * @example
  * ```gml
  * MobileUtils_AppPopupSettings_Show();
  * ```
  * @function_end
  */

// Modules

 /**
 * @module media
 * @title Mobile Media
 * @desc This module allows **Android** and **iOS** developers to interact with the camera and gallery applications of the mobile device.
 * 
 * [[Info: In order to avoid injecting unnecessary permissions into the application manifest this module is separated into four distinct modules depending on your game requirements.]]
 * 
 * @section_func Camera Functions
 * @desc These functions are provided to work with the camera.
 * @ref MobileUtils_Camera_Open
 * @section_end
 * 
 * @section_func Gallery Functions
 * @desc These functions are provided to work with the gallery.
 * @ref MobileUtils_Gallery_Open
 * @section_end
 * 
 * @section_func Image Tools Functions
 * @desc These functions are provided to work with images and edit them.
 * @ref MobileUtils_Image_Width
 * @ref MobileUtils_Image_Height
 * @ref MobileUtils_Image_Resize
 * @ref MobileUtils_Image_Crop
 * @section_end
 * 
 * @section_func Share Functions
 * @desc These functions are provided to share files.
 * @ref MobileUtils_Share_Open
 * @section_end
 *
 * 
 * @section_func Settings Functions
 * @desc These functions are provided to interact with settings.
 * @ref MobileUtils_AppPopupSettings_Show 
 * @section_end
 * 
 * @module_end
 */