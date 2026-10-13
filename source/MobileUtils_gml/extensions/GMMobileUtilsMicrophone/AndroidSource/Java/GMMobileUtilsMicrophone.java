package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.enums.MicPermission;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;

import androidx.core.content.ContextCompat;

public class GMMobileUtilsMicrophone extends GMMobileUtilsMicrophoneInternal {

    private static final int MIC_PERMISSION_REQUEST_CODE = 0x4D49; // 'MI'

    // Requests the RECORD_AUDIO runtime permission. No-op if already granted.
    // Fire-and-forget by design (see spec.gmidl) — call mic_check()
    // afterward (e.g. on the next room step or app resume) to read the result.
    public void mic_request() {
        final Activity activity = RunnerActivity.CurrentActivity;
        if (activity == null)
            return;

        if (ContextCompat.checkSelfPermission(activity, Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED)
            return;

        activity.runOnUiThread(() ->
            activity.requestPermissions(
                new String[]{ Manifest.permission.RECORD_AUDIO },
                MIC_PERMISSION_REQUEST_CODE
            )
        );
    }

    // callback(status) where status is a MicPermission value.
    public void mic_check(GMFunction callback) {
        final Activity activity = RunnerActivity.CurrentActivity;
        if (activity == null) {
            callback.call(MicPermission.Unknown.value());
            return;
        }

        if (ContextCompat.checkSelfPermission(activity, Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED) {
            callback.call(MicPermission.Granted.value());
        } else if (activity.shouldShowRequestPermissionRationale(Manifest.permission.RECORD_AUDIO)) {
            // Requested before and denied (rationale should be shown).
            callback.call(MicPermission.Denied.value());
        } else {
            // Either never requested, or permanently denied ("Don't ask again").
            callback.call(MicPermission.NotDetermined.value());
        }
    }
}
