
var _file = "mSharedImage.jpg"; 
file_copy("YYImage.jpg", _file); 
share_open( "Title!", "image/jpeg", _file, 
	function(_success, _error) 
	{ 
		if (_success) 
		{ 
			show_debug_message( "Image share chooser opened." ); 
		} 
		else 
		{ 
			show_debug_message( "Image share failed: " + _error ); 
		} 
	});
