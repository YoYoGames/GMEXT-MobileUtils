
var _file = "YYSharedPdf.pdf"; 
file_copy("YYPdf.pdf", _file); 
mobile_utils_share_open( "Title!", "application/pdf", _file, function(_success, _error) 
	{ 
		if (_success) 
		{ 
			show_debug_message( "PDF share chooser opened." ); 
		} 
		else 
		{ 
			show_debug_message( "PDF share failed: " + _error ); 
		} 
	});