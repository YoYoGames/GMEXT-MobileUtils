// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum VibrationAvailability
{
    None((int)0),
    Basic((int)1),
    HapticEngine((int)2);

    private final int value;
    private VibrationAvailability(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static VibrationAvailability from(int v)
    {
        switch (v)
        {
            case 0:
                return VibrationAvailability.None;
            case 1:
                return VibrationAvailability.Basic;
            case 2:
                return VibrationAvailability.HapticEngine;
            default:
                throw new IllegalArgumentException("Unknown VibrationAvailability value: " + v);
        }
    }
}