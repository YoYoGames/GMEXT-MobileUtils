
package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.os.Build;
import android.os.StrictMode;
import android.util.Log;

import java.io.File;
import java.lang.SecurityException;

import java.lang.Exception;

import java.util.Date;
import java.text.SimpleDateFormat;

import androidx.core.content.FileProvider;

public class MobileUtils_Camera extends RunnerSocial
{
	int MY_PERMISSIONS = 9;
	int EVENT_OTHER_SOCIAL = 70;
	int CAMERA_REQUEST_CODE = 17;
	
	String currentPhotoPath;
	
	Activity activity = RunnerActivity.CurrentActivity;
	
	private File createImageFile() throws Exception {
		// Create an image file name
		String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
		String imageFileName = "JPEG_" + timeStamp + "_";
		File storageDir = activity.getExternalFilesDir(Environment.DIRECTORY_PICTURES);
		File image = File.createTempFile(
			imageFileName,  /* prefix */
			".jpg",         /* suffix */
			storageDir      /* directory */
		);

		currentPhotoPath = image.getAbsolutePath();
		
		return image;
	}
	
	 public double MobileUtils_Camera_Open()
	 {
		try
		{
			StrictMode.VmPolicy.Builder newbuilder = new StrictMode.VmPolicy.Builder();
			StrictMode.setVmPolicy(newbuilder.build());
			Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
			//if (takePictureIntent.resolveActivity(activity.getPackageManager()) != null) 
			{
				File photoFile = null;
				try 
				{
					photoFile = createImageFile();
				} 
				catch (Exception ex) 
				{
					Log.i("yoyo","Camera_Start error");
					// Error occurred while creating the File
				}
				// Continue only if the File was successfully created
				if (photoFile != null) 
				{
					Uri photoURI = FileProvider.getUriForFile(activity, activity.getPackageName() + ".camera",photoFile);
					takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI);
					activity.startActivityForResult(takePictureIntent, CAMERA_REQUEST_CODE);
				}
			}
	 		return 1;
		}
		catch (SecurityException e)
		{
			return -1.0;
		}
	}
	
	@Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) 
	{
		if (resultCode == Activity.RESULT_OK)
		if (requestCode == CAMERA_REQUEST_CODE) 
		{
			int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
			RunnerJNILib.DsMapAddString( dsMapIndex,"type","MobileUtils_Camera_Open" );
			RunnerJNILib.DsMapAddString( dsMapIndex,"path",currentPhotoPath);
			RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
		}
	}
}

