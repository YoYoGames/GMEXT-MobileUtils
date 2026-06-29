// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum MobileUtilsNotificationPermission
{
    Unknown((int)0),
    NotDetermined((int)1),
    Denied((int)2),
    Authorized((int)3),
    Provisional((int)4),
    Ephemeral((int)5);

    private final int value;
    private MobileUtilsNotificationPermission(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static MobileUtilsNotificationPermission from(int v)
    {
        switch (v)
        {
            case 0:
                return MobileUtilsNotificationPermission.Unknown;
            case 1:
                return MobileUtilsNotificationPermission.NotDetermined;
            case 2:
                return MobileUtilsNotificationPermission.Denied;
            case 3:
                return MobileUtilsNotificationPermission.Authorized;
            case 4:
                return MobileUtilsNotificationPermission.Provisional;
            case 5:
                return MobileUtilsNotificationPermission.Ephemeral;
            default:
                throw new IllegalArgumentException("Unknown MobileUtilsNotificationPermission value: " + v);
        }
    }
}