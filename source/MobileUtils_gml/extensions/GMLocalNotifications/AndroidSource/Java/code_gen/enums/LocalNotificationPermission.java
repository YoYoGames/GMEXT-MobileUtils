// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum LocalNotificationPermission
{
    Unknown((int)0),
    NotDetermined((int)1),
    Denied((int)2),
    Authorized((int)3),
    Provisional((int)4),
    Ephemeral((int)5);

    private final int value;
    private LocalNotificationPermission(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static LocalNotificationPermission from(int v)
    {
        switch (v)
        {
            case 0:
                return LocalNotificationPermission.Unknown;
            case 1:
                return LocalNotificationPermission.NotDetermined;
            case 2:
                return LocalNotificationPermission.Denied;
            case 3:
                return LocalNotificationPermission.Authorized;
            case 4:
                return LocalNotificationPermission.Provisional;
            case 5:
                return LocalNotificationPermission.Ephemeral;
            default:
                throw new IllegalArgumentException("Unknown LocalNotificationPermission value: " + v);
        }
    }
}