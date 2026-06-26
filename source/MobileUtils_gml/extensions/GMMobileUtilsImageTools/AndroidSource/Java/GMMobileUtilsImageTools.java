package ${YYAndroidPackageName};

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import java.io.File;
import java.io.FileOutputStream;

public class GMMobileUtilsImageTools
    extends GMMobileUtilsImageToolsInternal
{
    public double mobile_utils_image_width(String path)
    {
        BitmapFactory.Options options =
            new BitmapFactory.Options();

        options.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(path, options);

        return options.outWidth > 0
            ? (double)options.outWidth
            : -1.0;
    }

    public double mobile_utils_image_height(String path)
    {
        BitmapFactory.Options options =
            new BitmapFactory.Options();

        options.inJustDecodeBounds = true;
        BitmapFactory.decodeFile(path, options);

        return options.outHeight > 0
            ? (double)options.outHeight
            : -1.0;
    }

    public boolean mobile_utils_image_resize(
        String path,
        double width,
        double height)
    {
        if (width <= 0.0 || height <= 0.0)
            return false;

        Bitmap source = null;
        Bitmap resized = null;

        try
        {
            source = BitmapFactory.decodeFile(path);

            if (source == null)
                return false;

            resized = Bitmap.createScaledBitmap(
                source,
                (int)width,
                (int)height,
                true
            );

            return writePng(path, resized);
        }
        catch (Exception exception)
        {
            return false;
        }
        finally
        {
            if (resized != null && resized != source)
                resized.recycle();

            if (source != null)
                source.recycle();
        }
    }

    public boolean mobile_utils_image_crop(
        String path,
        double width,
        double height,
        double offsetX,
        double offsetY)
    {
        Bitmap source = null;
        Bitmap cropped = null;

        try
        {
            source = BitmapFactory.decodeFile(path);

            if (source == null)
                return false;

            int x = (int)offsetX;
            int y = (int)offsetY;
            int w = (int)width;
            int h = (int)height;

            if (x < 0 || y < 0 || w <= 0 || h <= 0)
                return false;

            if (x + w > source.getWidth() ||
                y + h > source.getHeight())
            {
                return false;
            }

            cropped = Bitmap.createBitmap(
                source,
                x,
                y,
                w,
                h
            );

            return writePng(path, cropped);
        }
        catch (Exception exception)
        {
            return false;
        }
        finally
        {
            if (cropped != null && cropped != source)
                cropped.recycle();

            if (source != null)
                source.recycle();
        }
    }

    private static boolean writePng(
        String path,
        Bitmap bitmap)
    {
        try (
            FileOutputStream stream =
                new FileOutputStream(new File(path))
        )
        {
            boolean success = bitmap.compress(
                Bitmap.CompressFormat.PNG,
                100,
                stream
            );

            stream.flush();
            return success;
        }
        catch (Exception exception)
        {
            return false;
        }
    }
}
