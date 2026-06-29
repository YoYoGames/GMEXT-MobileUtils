
function mobile_utils_vibrate_is_available() {
	if (navigator.vibrate) {
		return 1.0;
	} else {
		return 0.0;
	}
}

function mobile_utils_vibrate_shot(milliseconds) {
    navigator.vibrate(milliseconds);
}

function mobile_utils_vibrate_predefined(kind) {
	console.log("MobileUtils_Vibrate_Predefined: Function Not Available on HTML Export");
}

