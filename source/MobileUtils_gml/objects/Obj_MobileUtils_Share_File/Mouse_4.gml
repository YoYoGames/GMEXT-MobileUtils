
var _file = "YYSharedFile.yy"; 
file_copy("YYFile.yy", _file); 
mobile_utils_share_open( "Title!", "*/*", _file, 
	function(_success, _error) 
	{ 
		if (_success) 
		{ 
			show_debug_message( "Generic file share chooser opened." ); 
		} 
		else 
		{ 
			show_debug_message( "Generic file share failed: " + _error ); 
		}
	});
