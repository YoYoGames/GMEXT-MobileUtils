
mobile_utils_share_open( "Title!", "text/plain", "Hello World", 
	function(_success, _error) 
	{ 
		if (_success) 
		{ 
			show_debug_message( "Text share chooser opened." ); 
		} 
		else 
		{ 
			show_debug_message( "Text share failed: " + _error ); 
		} 
	});
