
var _file = "SharedGif.gif"; 
file_copy("YYGif.gif", _file); 
mobile_utils_share_open( "Title!", "image/gif", _file, 
	function(_success, _error) 
	{ 
		if (_success) 
		{ 
			show_debug_message( "GIF share chooser opened." ); 
		} 
		else 
		{ 
			show_debug_message( "GIF share failed: " + _error ); 
		}
	});
