function MobileUtils_Web_Vibrate_Available() {
	if (navigator.vibrate) {
		return 1.0;
	} else {
		return 0.0;
	}
}


function MobileUtils_Web_Vibrate_Shot(milliseconds) {

    navigator.vibrate(milliseconds);
}

function MobileUtils_Web_Vibrate_Stop() {

    navigator.vibrate(0);
}