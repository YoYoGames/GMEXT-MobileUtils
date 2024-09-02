
event_inherited()

kind_array = []

index = 0

text = $"Predefined: {index}"

if(os_type == os_android)
{
	kind_array = [
			MobileUtils_VIBRATE_KIND_ANDROID_CLICK,
			MobileUtils_VIBRATE_KIND_ANDROID_DOUBLE_CLICK,
			MobileUtils_VIBRATE_KIND_ANDROID_HEAVY_CLICK,
			MobileUtils_VIBRATE_KIND_ANDROID_TICK
		]
}
else
if(os_type == os_ios)
{
	kind_array = [
		MobileUtils_VIBRATE_KIND_IOS_IMPACT_LIGHT,
		MobileUtils_VIBRATE_KIND_IOS_IMPACT_MEDIUM,
		MobileUtils_VIBRATE_KIND_IOS_IMPACT_HEAVY,
		MobileUtils_VIBRATE_KIND_IOS_IMPACT_RIGID,
		MobileUtils_VIBRATE_KIND_IOS_IMPACT_SOFT,
		MobileUtils_VIBRATE_KIND_IOS_SELECTION,
		MobileUtils_VIBRATE_KIND_IOS_NOTIFICATION_WARNING,
		MobileUtils_VIBRATE_KIND_IOS_NOTIFICATION_SUCCESS,
		MobileUtils_VIBRATE_KIND_IOS_NOTIFICATION_ERROR
	]
}
