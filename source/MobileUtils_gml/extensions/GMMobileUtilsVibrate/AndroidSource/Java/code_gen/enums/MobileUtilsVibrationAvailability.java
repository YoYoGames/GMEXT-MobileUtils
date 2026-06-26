// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum MobileUtilsVibrationAvailability
{
    None((int)0),
    Basic((int)1),
    HapticEngine((int)2);

    private final int value;
    private MobileUtilsVibrationAvailability(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static MobileUtilsVibrationAvailability from(int v)
    {
        switch (v)
        {
            case 0:
                return MobileUtilsVibrationAvailability.None;
            case 1:
                return MobileUtilsVibrationAvailability.Basic;
            case 2:
                return MobileUtilsVibrationAvailability.HapticEngine;
            default:
                throw new IllegalArgumentException("Unknown MobileUtilsVibrationAvailability value: " + v);
        }
    }
}