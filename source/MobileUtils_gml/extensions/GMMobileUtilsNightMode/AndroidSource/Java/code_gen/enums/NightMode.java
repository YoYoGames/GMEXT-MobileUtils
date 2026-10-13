// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum NightMode
{
    Dark((int)0),
    Light((int)1),
    Undefined((int)2);

    private final int value;
    private NightMode(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static NightMode from(int v)
    {
        switch (v)
        {
            case 0:
                return NightMode.Dark;
            case 1:
                return NightMode.Light;
            case 2:
                return NightMode.Undefined;
            default:
                throw new IllegalArgumentException("Unknown NightMode value: " + v);
        }
    }
}