
function mobile_utils_vibrate_is_available() {
	if (navigator.vibrate) {
		return 1.0;
	} else {
		return 0.0;
	}
}

function mobile_utils_vibrate_shot(milliseconds) {
	if (navigator.vibrate) {
		navigator.vibrate(milliseconds);
		return 1.0;
	}
	return 0.0;
}

function mobile_utils_vibrate_predefined(kind) {
	console.log("mobile_utils_vibrate_predefined: Function Not Available on HTML Export");
	return 0.0;
}

