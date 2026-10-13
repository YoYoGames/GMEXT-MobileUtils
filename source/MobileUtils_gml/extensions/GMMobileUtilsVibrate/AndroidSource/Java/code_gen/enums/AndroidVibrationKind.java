// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum AndroidVibrationKind
{
    Click((int)0),
    DoubleClick((int)1),
    Tick((int)2),
    HeavyClick((int)5);

    private final int value;
    private AndroidVibrationKind(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static AndroidVibrationKind from(int v)
    {
        switch (v)
        {
            case 0:
                return AndroidVibrationKind.Click;
            case 1:
                return AndroidVibrationKind.DoubleClick;
            case 2:
                return AndroidVibrationKind.Tick;
            case 5:
                return AndroidVibrationKind.HeavyClick;
            default:
                throw new IllegalArgumentException("Unknown AndroidVibrationKind value: " + v);
        }
    }
}