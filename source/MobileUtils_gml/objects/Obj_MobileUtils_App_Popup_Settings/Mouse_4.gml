
mobile_utils_app_popup_settings_show(
    function(_success, _error)
    {
        if (_success)
        {
            show_debug_message(
                "Application settings opened successfully."
            );
        }
        else
        {
            show_debug_message(
                "Could not open application settings: " + _error
            );
        }
    }
);

