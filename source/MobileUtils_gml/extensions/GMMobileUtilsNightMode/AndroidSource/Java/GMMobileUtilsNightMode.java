package ${YYAndroidPackageName};

import android.app.Activity;
import android.content.res.Configuration;

public class GMMobileUtilsNightMode
    extends GMMobileUtilsNightModeInternal
{
    public double mobile_utils_night_mode_check()
    {
        Activity activity = RunnerActivity.CurrentActivity;

        if (activity == null)
            return 2.0;

        int mode =
            activity.getResources()
                .getConfiguration()
                .uiMode
            & Configuration.UI_MODE_NIGHT_MASK;

        switch (mode)
        {
            case Configuration.UI_MODE_NIGHT_YES:
                return 0.0;

            case Configuration.UI_MODE_NIGHT_NO:
                return 1.0;

            default:
                return 2.0;
        }
    }
}
