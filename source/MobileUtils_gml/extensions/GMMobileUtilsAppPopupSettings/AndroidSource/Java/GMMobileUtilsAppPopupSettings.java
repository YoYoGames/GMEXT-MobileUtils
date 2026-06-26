
package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.GMExtWire.GMFunction;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.provider.Settings;

public class GMMobileUtilsAppPopupSettings extends GMMobileUtilsAppPopupSettingsInternal
{
    public void mobile_utils_app_popup_settings_show(final GMFunction callback)
    {
        final Activity activity = RunnerActivity.CurrentActivity;

        if (activity == null)
        {
            callback.call(false, "Activity is null.");
            return;
        }

        activity.runOnUiThread(() ->
        {
            try
            {
                final Intent intent = new Intent(
                    Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                    Uri.fromParts(
                        "package",
                        activity.getPackageName(),
                        null
                    )
                );

                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                activity.startActivity(intent);

                callback.call(true, "");
            }
            catch (Exception exception)
            {
                callback.call(false, error(exception));
            }
        });
    }

    private static String error(Throwable throwable)
    {
        if (throwable == null)
            return "Unknown application settings error.";

        final String message = throwable.getMessage();
        return message != null ? message : throwable.toString();
    }
}
