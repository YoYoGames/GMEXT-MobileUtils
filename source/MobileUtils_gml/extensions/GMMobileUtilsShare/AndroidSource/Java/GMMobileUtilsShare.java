package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.GMExtWire.GMFunction;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.webkit.MimeTypeMap;

import androidx.core.content.FileProvider;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.channels.FileChannel;

/**
 * Extension Generator conversion of MobileUtils_Share.
 *
 * Callback:
 *     callback(success, error)
 *
 * Success means that Android successfully launched the share chooser.
 * Android does not report whether the user ultimately shared the content.
 */
public class GMMobileUtilsShare extends GMMobileUtilsShareInternal
{
    public void mobile_utils_share_open(
        String title,
        String mime,
        String value,
        final GMFunction callback)
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
                final Intent shareIntent = new Intent(Intent.ACTION_SEND);
                final String safeMime =
                    mime != null && !mime.isEmpty() ? mime : "*/*";

                shareIntent.setType(safeMime);

                if (isTextMimeType(safeMime))
                {
                    shareIntent.putExtra(
                        Intent.EXTRA_TEXT,
                        value != null ? value : ""
                    );
                }
                else
                {
                    final File baseDir = activity.getFilesDir();
                    final File sourceFile = new File(baseDir, value);

                    // Subfolders (e.g. "my_images/pic.png") are allowed, but the
                    // resolved path must stay inside the app private dir — reject
                    // ../ traversal or absolute paths that escape the sandbox.
                    final String basePath = baseDir.getCanonicalPath();
                    final String resolvedPath = sourceFile.getCanonicalPath();

                    if (!resolvedPath.equals(basePath)
                        && !resolvedPath.startsWith(basePath + File.separator))
                    {
                        callback.call(false, "Invalid file path.");
                        return;
                    }

                    if (!sourceFile.exists())
                    {
                        callback.call(
                            false,
                            "Source file does not exist: "
                                + sourceFile.getAbsolutePath()
                        );
                        return;
                    }

                    final File externalDirectory =
                        activity.getExternalFilesDir(null);

                    if (externalDirectory == null)
                    {
                        callback.call(
                            false,
                            "External files directory is unavailable."
                        );
                        return;
                    }

                    final File sharedFile =
                        new File(externalDirectory, sourceFile.getName());

                    copyFile(sourceFile, sharedFile);

                    final Uri fileUri = FileProvider.getUriForFile(
                        activity,
                        activity.getPackageName() + ".share.fileprovider",
                        sharedFile
                    );

                    String detectedMime =
                        getMimeType(sharedFile.getAbsolutePath());

                    if (detectedMime != null && !detectedMime.isEmpty())
                        shareIntent.setType(detectedMime);

                    shareIntent.putExtra(Intent.EXTRA_STREAM, fileUri);
                    shareIntent.addFlags(
                        Intent.FLAG_GRANT_READ_URI_PERMISSION
                    );
                }

                activity.startActivity(
                    Intent.createChooser(
                        shareIntent,
                        title != null ? title : ""
                    )
                );

                callback.call(true, "");
            }
            catch (Exception exception)
            {
                callback.call(false, error(exception));
            }
        });
    }

    private static boolean isTextMimeType(String mime)
    {
        return "text/plain".equals(mime)
            || "text/rtf".equals(mime)
            || "text/html".equals(mime)
            || "text/json".equals(mime)
            || "application/json".equals(mime);
    }

    private static void copyFile(File source, File destination)
        throws Exception
    {
        File parent = destination.getParentFile();
        if (parent != null && !parent.exists() && !parent.mkdirs())
        {
            throw new IllegalStateException(
                "Could not create destination directory."
            );
        }

        try (
            FileInputStream inputStream =
                new FileInputStream(source);
            FileOutputStream outputStream =
                new FileOutputStream(destination);
            FileChannel inputChannel = inputStream.getChannel();
            FileChannel outputChannel = outputStream.getChannel()
        )
        {
            inputChannel.transferTo(
                0,
                inputChannel.size(),
                outputChannel
            );
        }
    }

    private static String getMimeType(String path)
    {
        String extension =
            MimeTypeMap.getFileExtensionFromUrl(path);

        if (extension == null || extension.isEmpty())
            return null;

        return MimeTypeMap.getSingleton()
            .getMimeTypeFromExtension(extension.toLowerCase());
    }

    private static String error(Throwable throwable)
    {
        if (throwable == null)
            return "Unknown share error.";

        String message = throwable.getMessage();
        return message != null ? message : throwable.toString();
    }
}
