// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum MicPermission
{
    Unknown((int)0),
    NotDetermined((int)1),
    Denied((int)2),
    Granted((int)3);

    private final int value;
    private MicPermission(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static MicPermission from(int v)
    {
        switch (v)
        {
            case 0:
                return MicPermission.Unknown;
            case 1:
                return MicPermission.NotDetermined;
            case 2:
                return MicPermission.Denied;
            case 3:
                return MicPermission.Granted;
            default:
                throw new IllegalArgumentException("Unknown MicPermission value: " + v);
        }
    }
}