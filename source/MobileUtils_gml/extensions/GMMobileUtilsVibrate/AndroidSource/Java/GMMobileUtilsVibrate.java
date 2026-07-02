package ${YYAndroidPackageName};

import android.app.Activity;
import android.content.Context;
import android.os.Build;
import android.os.VibrationEffect;
import android.os.Vibrator;
import android.os.VibratorManager;

public class GMMobileUtilsVibrate
    extends GMMobileUtilsVibrateInternal
{
    public double mobile_utils_vibrate_is_available()
    {
        Activity activity = RunnerActivity.CurrentActivity;

        if (activity == null)
            return 0.0;

        Vibrator vibrator = getVibrator(activity);

        return vibrator != null && vibrator.hasVibrator()
            ? 1.0
            : 0.0;
    }

    public boolean mobile_utils_vibrate_predefined(double kind)
    {
        Activity activity = RunnerActivity.CurrentActivity;

        if (activity == null)
            return false;

        int effect = (int)kind;

        if (!isValidAndroidEffect(effect))
            return false;

        try
        {
            Vibrator vibrator = getVibrator(activity);

            if (vibrator == null || !vibrator.hasVibrator())
                return false;

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
            {
                vibrator.vibrate(
                    VibrationEffect.createPredefined(effect)
                );
            }
            else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
            {
                vibrator.vibrate(
                    VibrationEffect.createOneShot(
                        fallbackDuration(effect),
                        VibrationEffect.DEFAULT_AMPLITUDE
                    )
                );
            }
            else
            {
                vibrator.vibrate(fallbackDuration(effect));
            }

            return true;
        }
        catch (Exception exception)
        {
            return false;
        }
    }

    public boolean mobile_utils_vibrate_shot(double milliseconds)
    {
        Activity activity = RunnerActivity.CurrentActivity;

        if (activity == null || milliseconds <= 0.0)
            return false;

        try
        {
            Vibrator vibrator = getVibrator(activity);

            if (vibrator == null || !vibrator.hasVibrator())
                return false;

            long duration = Math.max(1L, (long)milliseconds);

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
            {
                vibrator.vibrate(
                    VibrationEffect.createOneShot(
                        duration,
                        VibrationEffect.DEFAULT_AMPLITUDE
                    )
                );
            }
            else
            {
                vibrator.vibrate(duration);
            }

            return true;
        }
        catch (Exception exception)
        {
            return false;
        }
    }

    private static Vibrator getVibrator(Activity activity)
    {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S)
        {
            VibratorManager manager =
                (VibratorManager)activity.getSystemService(
                    Context.VIBRATOR_MANAGER_SERVICE
                );

            return manager != null
                ? manager.getDefaultVibrator()
                : null;
        }

        return (Vibrator)activity.getSystemService(
            Context.VIBRATOR_SERVICE
        );
    }

    private static boolean isValidAndroidEffect(int effect)
    {
        return effect == VibrationEffect.EFFECT_CLICK
            || effect == VibrationEffect.EFFECT_DOUBLE_CLICK
            || effect == VibrationEffect.EFFECT_TICK
            || effect == VibrationEffect.EFFECT_HEAVY_CLICK;
    }

    private static long fallbackDuration(int effect)
    {
        switch (effect)
        {
            case VibrationEffect.EFFECT_DOUBLE_CLICK:
                return 60L;

            case VibrationEffect.EFFECT_TICK:
                return 20L;

            case VibrationEffect.EFFECT_HEAVY_CLICK:
                return 80L;

            case VibrationEffect.EFFECT_CLICK:
            default:
                return 40L;
        }
    }
}
