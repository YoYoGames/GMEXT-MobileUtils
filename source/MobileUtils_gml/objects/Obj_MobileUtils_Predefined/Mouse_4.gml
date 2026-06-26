
var _count = array_length(kind_array);

if (_count == 0)
{
    exit;
}

if (!mobile_utils_vibrate_is_available())
{
    show_debug_message("Vibration is not available.");
    exit;
}

var _kind = kind_array[index];

var _success =
    mobile_utils_vibrate_predefined(_kind);

if (!_success)
{
    show_debug_message(
        $"Could not play predefined vibration: {index}"
    );
}

index++;

if (index >= _count)
{
    index = 0;
}

text = $"Predefined: {index}";

