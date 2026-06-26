// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum MobileUtilsIOSVibrationKind
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
    private MobileUtilsIOSVibrationKind(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static MobileUtilsIOSVibrationKind from(int v)
    {
        switch (v)
        {
            case 0:
                return MobileUtilsIOSVibrationKind.ImpactLight;
            case 1:
                return MobileUtilsIOSVibrationKind.ImpactMedium;
            case 2:
                return MobileUtilsIOSVibrationKind.ImpactHeavy;
            case 3:
                return MobileUtilsIOSVibrationKind.ImpactRigid;
            case 4:
                return MobileUtilsIOSVibrationKind.ImpactSoft;
            case 10:
                return MobileUtilsIOSVibrationKind.Selection;
            case 20:
                return MobileUtilsIOSVibrationKind.NotificationWarning;
            case 21:
                return MobileUtilsIOSVibrationKind.NotificationSuccess;
            case 22:
                return MobileUtilsIOSVibrationKind.NotificationError;
            default:
                throw new IllegalArgumentException("Unknown MobileUtilsIOSVibrationKind value: " + v);
        }
    }
}