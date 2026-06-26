mobile_utils_apn_register(
    function(_success, _token, _error)
    {
        if (_success)
        {
            show_debug_message(
                "APNs registration succeeded."
            );

            show_debug_message(
                "Device token: " + _token
            );

            // Send _token to your backend.
        }
        else
        {
            show_debug_message(
                "APNs registration failed: " + _error
            );
        }
    }
);
