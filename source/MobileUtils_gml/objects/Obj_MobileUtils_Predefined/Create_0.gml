
event_inherited();

kind_array = [];
index = 0;

if (os_type == os_android)
{
    kind_array =
    [
        AndroidVibrationKind.Click,
        AndroidVibrationKind.DoubleClick,
        AndroidVibrationKind.HeavyClick,
        AndroidVibrationKind.Tick
    ];
}
else if (os_type == os_ios)
{
    kind_array =
    [
        IOSVibrationKind.ImpactLight,
        IOSVibrationKind.ImpactMedium,
        IOSVibrationKind.ImpactHeavy,
        IOSVibrationKind.ImpactRigid,
        IOSVibrationKind.ImpactSoft,
        IOSVibrationKind.Selection,
        IOSVibrationKind.NotificationWarning,
        IOSVibrationKind.NotificationSuccess,
        IOSVibrationKind.NotificationError
    ];
}

text = $"Predefined: {index}";

