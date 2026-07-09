// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum MobileUtilsMicPermission
{
    Unknown((int)0),
    NotDetermined((int)1),
    Denied((int)2),
    Granted((int)3);

    private final int value;
    private MobileUtilsMicPermission(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static MobileUtilsMicPermission from(int v)
    {
        switch (v)
        {
            case 0:
                return MobileUtilsMicPermission.Unknown;
            case 1:
                return MobileUtilsMicPermission.NotDetermined;
            case 2:
                return MobileUtilsMicPermission.Denied;
            case 3:
                return MobileUtilsMicPermission.Granted;
            default:
                throw new IllegalArgumentException("Unknown MobileUtilsMicPermission value: " + v);
        }
    }
}