
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

import android.graphics.Bitmap;
import android.os.Bundle;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import android.graphics.Bitmap.CompressFormat;

public class MobileUtils_Camera extends RunnerSocial
{
	Activity activity = RunnerActivity.CurrentActivity;
	
	int MY_PERMISSIONS = 9;
	int EVENT_OTHER_SOCIAL = 70;
	int CAMERA_REQUEST_CODE = 17;
	
	 public double MobileUtils_Camera_Open()
	 {
		try
		{
			StrictMode.VmPolicy.Builder newbuilder = new StrictMode.VmPolicy.Builder();
			StrictMode.setVmPolicy(newbuilder.build());
			Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
			activity.startActivityForResult(takePictureIntent, CAMERA_REQUEST_CODE);
			
			// //if (takePictureIntent.resolveActivity(activity.getPackageManager()) != null) 
			// {
				// File photoFile = null;
				// try 
				// {
					// photoFile = createImageFile();
				// } 
				// catch (Exception ex) 
				// {
					// Log.i("yoyo","Camera_Start error");
					// // Error occurred while creating the File
				// }
				// // Continue only if the File was successfully created
				// if (photoFile != null) 
				// {
					// Uri photoURI = FileProvider.getUriForFile(activity, activity.getPackageName() + ".camera",photoFile);
					// takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI);
					// activity.startActivityForResult(takePictureIntent, CAMERA_REQUEST_CODE);
				// }
			// }
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
		// Log.i("yoyo","Camera onActivityResult: " + String.valueOf(resultCode) + " - " + String.valueOf(Activity.RESULT_OK));
		
		try 
		{
			if (requestCode == CAMERA_REQUEST_CODE) 
			{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString( dsMapIndex,"type","MobileUtils_Camera_Open" );
				
				if (resultCode == Activity.RESULT_OK)
				{
					
					RunnerJNILib.DsMapAddDouble( dsMapIndex,"success",1.0);
					
					Uri selectedImage = data.getData();//convert to for bitmap that can send
					Bundle extras = data.getExtras();//finish converting and copy the image
					Bitmap bitmap = extras.getParcelable("data");//receive image to bitmap
					
					File imagePath = new File(activity.getFilesDir(), "my_pics"); 
					imagePath.mkdir();
					File newFile = new File(imagePath, "temp.jpeg"); 
					
					//create a file to write bitmap data
					newFile.createNewFile();

					//Convert bitmap to byte array
					ByteArrayOutputStream bos = new ByteArrayOutputStream();
					bitmap.compress(CompressFormat.PNG, 0 /*ignored for PNG*/, bos);
					byte[] bitmapdata = bos.toByteArray();

					//write the bytes in file
					FileOutputStream fos = new FileOutputStream(newFile);
					fos.write(bitmapdata);
					fos.flush();
					fos.close();
					
					RunnerJNILib.DsMapAddString( dsMapIndex,"path",newFile.toString());
				}
				else
					RunnerJNILib.DsMapAddDouble( dsMapIndex,"success",0.0);
				
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
			}
		}
		catch(Exception e)
		{
				int dsMapIndex = RunnerJNILib.jCreateDsMap(null, null, null);
				RunnerJNILib.DsMapAddString( dsMapIndex,"type","MobileUtils_Camera_Open" );
				RunnerJNILib.DsMapAddDouble( dsMapIndex,"success",0.0);
				RunnerJNILib.CreateAsynEventWithDSMap(dsMapIndex, EVENT_OTHER_SOCIAL);
		}
	}
}

