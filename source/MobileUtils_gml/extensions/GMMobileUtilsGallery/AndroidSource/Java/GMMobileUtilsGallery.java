
package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.GMExtWire.GMFunction;

import android.app.Activity;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.provider.OpenableColumns;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * Extension Generator conversion of MobileUtils_Gallery.
 *
 * Callback:
 *     callback(success, path, filename, error)
 *
 * The selected content URI is copied into the app internal files directory so
 * GameMaker receives a stable local filesystem path.
 */
public class GMMobileUtilsGallery extends GMMobileUtilsGalleryInternal
{
    private static final int PICK_IMAGE_URI = 2;

    private volatile GMFunction galleryCallback = null;

    public void mobile_utils_gallery_open(final GMFunction callback)
    {
        final Activity activity = RunnerActivity.CurrentActivity;

        if (activity == null)
        {
            callback.call(false, "", "", "Activity is null.");
            return;
        }

        if (galleryCallback != null)
        {
            callback.call(
                false,
                "",
                "",
                "A gallery request is already active."
            );
            return;
        }

        galleryCallback = callback;

        activity.runOnUiThread(() ->
        {
            try
            {
                final Intent intent =
                    new Intent(Intent.ACTION_PICK);

                intent.setType("image/*");

                // if (intent.resolveActivity(
                        // activity.getPackageManager()) == null)
                // {
                    // finish(
                        // false,
                        // "",
                        // "",
                        // "No gallery application is available."
                    // );
                    // return;
                // }

                activity.startActivityForResult(
                    intent,
                    PICK_IMAGE_URI
                );
            }
            catch (Exception exception)
            {
                finish(false, "", "", error(exception));
            }
        });
    }

    @Override
    public void onActivityResult(
        int requestCode,
        int resultCode,
        Intent data)
    {
        if (requestCode != PICK_IMAGE_URI)
            return;

        if (resultCode != Activity.RESULT_OK)
        {
            finish(false, "", "", "Gallery selection was cancelled.");
            return;
        }

        if (data == null)
        {
            finish(false, "", "", "Gallery returned no Intent data.");
            return;
        }

        final Uri uri = data.getData();

        if (uri == null)
        {
            finish(false, "", "", "Gallery returned no image URI.");
            return;
        }

        final Activity activity = RunnerActivity.CurrentActivity;

        if (activity == null)
        {
            finish(false, "", "", "Activity is null.");
            return;
        }

        // The display-name query and the InputStream -> FileOutputStream copy can
        // block for hundreds of ms on large HEIC/photos. onActivityResult runs on
        // the UI thread, so run the copy on a worker and fire the (thread-safe)
        // callback from there. The content-URI read grant stays valid on the worker.
        new Thread(() ->
        {
            try
            {
                String fileName =
                    getDisplayName(activity, uri);

                if (fileName == null || fileName.isEmpty())
                    fileName = "temp.jpg";

                fileName = sanitizeFileName(fileName);

                final File outputFile =
                    new File(activity.getFilesDir(), fileName);

                try (
                    InputStream input =
                        activity.getContentResolver()
                            .openInputStream(uri);
                    OutputStream output =
                        new FileOutputStream(outputFile)
                )
                {
                    if (input == null)
                        throw new IllegalStateException(
                            "Could not open selected image."
                        );

                    final byte[] buffer = new byte[16 * 1024];
                    int read;

                    while ((read = input.read(buffer)) != -1)
                        output.write(buffer, 0, read);

                    output.flush();
                }

                finish(
                    true,
                    outputFile.getAbsolutePath(),
                    fileName,
                    ""
                );
            }
            catch (Exception exception)
            {
                finish(false, "", "", error(exception));
            }
        }).start();
    }

    private static String getDisplayName(
        Activity activity,
        Uri uri)
    {
        try (
            Cursor cursor =
                activity.getContentResolver().query(
                    uri,
                    new String[] {
                        OpenableColumns.DISPLAY_NAME
                    },
                    null,
                    null,
                    null
                )
        )
        {
            if (cursor == null || !cursor.moveToFirst())
                return null;

            final int index =
                cursor.getColumnIndex(
                    OpenableColumns.DISPLAY_NAME
                );

            return index >= 0
                ? cursor.getString(index)
                : null;
        }
        catch (Exception ignored)
        {
            return null;
        }
    }

    private static String sanitizeFileName(String value)
    {
        String result = value.replaceAll("[\\\\/:*?\"<>|]", "_");
        return result.isEmpty() ? "temp.jpg" : result;
    }

    private void finish(
        boolean success,
        String path,
        String filename,
        String error)
    {
        final GMFunction callback = galleryCallback;
        galleryCallback = null;

        if (callback != null)
            callback.call(success, path, filename, error);
    }

    private static String error(Throwable throwable)
    {
        if (throwable == null)
            return "Unknown gallery error.";

        final String message = throwable.getMessage();
        return message != null ? message : throwable.toString();
    }
}
