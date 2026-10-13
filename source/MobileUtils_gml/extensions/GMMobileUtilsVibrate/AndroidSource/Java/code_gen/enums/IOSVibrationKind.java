// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum IOSVibrationKind
{
    ImpactLight((int)0),
    ImpactMedium((int)1),
    ImpactHeavy((int)2),
    ImpactRigid((int)3),
    ImpactSoft((int)4),
    Selection((int)10),
    NotificationWarning((int)20),
    NotificationSuccess((int)21),
    NotificationError((int)22);

    private final int value;
    private IOSVibrationKind(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static IOSVibrationKind from(int v)
    {
        switch (v)
        {
            case 0:
                return IOSVibrationKind.ImpactLight;
            case 1:
                return IOSVibrationKind.ImpactMedium;
            case 2:
                return IOSVibrationKind.ImpactHeavy;
            case 3:
                return IOSVibrationKind.ImpactRigid;
            case 4:
                return IOSVibrationKind.ImpactSoft;
            case 10:
                return IOSVibrationKind.Selection;
            case 20:
                return IOSVibrationKind.NotificationWarning;
            case 21:
                return IOSVibrationKind.NotificationSuccess;
            case 22:
                return IOSVibrationKind.NotificationError;
            default:
                throw new IllegalArgumentException("Unknown IOSVibrationKind value: " + v);
        }
    }
}