// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum MobileUtilsAndroidVibrationKind
{
    Click((int)0),
    DoubleClick((int)1),
    Tick((int)2),
    HeavyClick((int)5);

    private final int value;
    private MobileUtilsAndroidVibrationKind(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static MobileUtilsAndroidVibrationKind from(int v)
    {
        switch (v)
        {
            case 0:
                return MobileUtilsAndroidVibrationKind.Click;
            case 1:
                return MobileUtilsAndroidVibrationKind.DoubleClick;
            case 2:
                return MobileUtilsAndroidVibrationKind.Tick;
            case 5:
                return MobileUtilsAndroidVibrationKind.HeavyClick;
            default:
                throw new IllegalArgumentException("Unknown MobileUtilsAndroidVibrationKind value: " + v);
        }
    }
}