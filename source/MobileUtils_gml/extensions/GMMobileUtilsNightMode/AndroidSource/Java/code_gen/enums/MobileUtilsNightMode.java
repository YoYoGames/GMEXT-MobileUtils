// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum MobileUtilsNightMode
{
    Dark((int)0),
    Light((int)1),
    Undefined((int)2);

    private final int value;
    private MobileUtilsNightMode(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static MobileUtilsNightMode from(int v)
    {
        switch (v)
        {
            case 0:
                return MobileUtilsNightMode.Dark;
            case 1:
                return MobileUtilsNightMode.Light;
            case 2:
                return MobileUtilsNightMode.Undefined;
            default:
                throw new IllegalArgumentException("Unknown MobileUtilsNightMode value: " + v);
        }
    }
}