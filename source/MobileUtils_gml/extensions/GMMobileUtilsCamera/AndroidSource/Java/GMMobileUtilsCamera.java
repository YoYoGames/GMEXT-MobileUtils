package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.GMExtWire.GMFunction;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.provider.MediaStore;

import java.io.File;
import java.io.FileOutputStream;

/**
 * Extension Generator conversion of MobileUtils_Camera.
 *
 * Callback:
 *     callback(success, path, error)
 *
 * This preserves the original behavior of using the thumbnail Bitmap returned
 * by ACTION_IMAGE_CAPTURE. It does not capture a full-resolution photograph.
 */
public class GMMobileUtilsCamera extends GMMobileUtilsCameraInternal
{
    private static final int CAMERA_REQUEST_CODE = 17;

    private volatile GMFunction cameraCallback = null;

    public void mobile_utils_camera_open(final GMFunction callback)
    {
        final Activity activity = RunnerActivity.CurrentActivity;

        if (activity == null)
        {
            callback.call(false, "", "Activity is null.");
            return;
        }

        if (cameraCallback != null)
        {
            callback.call(
                false,
                "",
                "A camera request is already active."
            );
            return;
        }

        cameraCallback = callback;

        activity.runOnUiThread(() ->
        {
            try
            {
                final Intent intent =
                    new Intent(MediaStore.ACTION_IMAGE_CAPTURE);

                if (intent.resolveActivity(
                        activity.getPackageManager()) == null)
                {
                    finish(
                        false,
                        "",
                        "No camera application is available."
                    );
                    return;
                }

                activity.startActivityForResult(
                    intent,
                    CAMERA_REQUEST_CODE
                );
            }
            catch (SecurityException exception)
            {
                finish(false, "", error(exception));
            }
            catch (Exception exception)
            {
                finish(false, "", error(exception));
            }
        });
    }

    @Override
    public void onActivityResult(
        int requestCode,
        int resultCode,
        Intent data)
    {
        if (requestCode != CAMERA_REQUEST_CODE)
            return;

        if (resultCode != Activity.RESULT_OK)
        {
            finish(false, "", "Camera capture was cancelled.");
            return;
        }

        try
        {
            if (data == null)
                throw new IllegalStateException(
                    "Camera returned no Intent data."
                );

            final Bundle extras = data.getExtras();

            if (extras == null)
                throw new IllegalStateException(
                    "Camera returned no image data."
                );

            final Object bitmapValue = extras.get("data");

            if (!(bitmapValue instanceof Bitmap))
                throw new IllegalStateException(
                    "Camera returned no thumbnail Bitmap."
                );

            final Bitmap bitmap = (Bitmap)bitmapValue;
            final Activity activity = RunnerActivity.CurrentActivity;

            if (activity == null)
                throw new IllegalStateException(
                    "Activity is null."
                );

            final File directory =
                activity.getExternalFilesDir(null);

            if (directory == null)
                throw new IllegalStateException(
                    "External files directory is unavailable."
                );

            final File output =
                new File(directory, "temp.png");

            // Bitmap.compress + write can block the UI thread (and will be a
            // guaranteed ANR once the capture becomes full-resolution), so encode on
            // a worker and fire the (thread-safe) callback from there.
            new Thread(() ->
            {
                try
                {
                    try (FileOutputStream stream =
                            new FileOutputStream(output))
                    {
                        final boolean compressed = bitmap.compress(
                            Bitmap.CompressFormat.PNG,
                            100,
                            stream
                        );

                        if (!compressed)
                            throw new IllegalStateException(
                                "Could not encode camera image."
                            );

                        stream.flush();
                    }

                    finish(true, output.getAbsolutePath(), "");
                }
                catch (Exception exception)
                {
                    finish(false, "", error(exception));
                }
            }).start();
        }
        catch (Exception exception)
        {
            finish(false, "", error(exception));
        }
    }

    private void finish(
        boolean success,
        String path,
        String error)
    {
        final GMFunction callback = cameraCallback;
        cameraCallback = null;

        if (callback != null)
            callback.call(success, path, error);
    }

    private static String error(Throwable throwable)
    {
        if (throwable == null)
            return "Unknown camera error.";

        final String message = throwable.getMessage();
        return message != null ? message : throwable.toString();
    }
}
