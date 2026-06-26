
event_inherited();

kind_array = [];
index = 0;

if (os_type == os_android)
{
    kind_array =
    [
        MobileUtilsAndroidVibrationKind.Click,
        MobileUtilsAndroidVibrationKind.DoubleClick,
        MobileUtilsAndroidVibrationKind.HeavyClick,
        MobileUtilsAndroidVibrationKind.Tick
    ];
}
else if (os_type == os_ios)
{
    kind_array =
    [
        MobileUtilsIOSVibrationKind.ImpactLight,
        MobileUtilsIOSVibrationKind.ImpactMedium,
        MobileUtilsIOSVibrationKind.ImpactHeavy,
        MobileUtilsIOSVibrationKind.ImpactRigid,
        MobileUtilsIOSVibrationKind.ImpactSoft,
        MobileUtilsIOSVibrationKind.Selection,
        MobileUtilsIOSVibrationKind.NotificationWarning,
        MobileUtilsIOSVibrationKind.NotificationSuccess,
        MobileUtilsIOSVibrationKind.NotificationError
    ];
}

text = $"Predefined: {index}";

