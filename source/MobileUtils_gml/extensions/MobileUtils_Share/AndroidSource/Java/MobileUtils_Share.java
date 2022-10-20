package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Environment;

import java.io.File;
import java.io.FileOutputStream;

import androidx.core.content.ContextCompat;
import android.Manifest;
import android.os.Build;

import android.os.StrictMode;
import android.provider.Settings;

import android.util.Log;

import java.io.FileInputStream;
import java.nio.channels.FileChannel;

import androidx.core.content.FileProvider;

public class MobileUtils_Share extends RunnerSocial
{	
	Activity activity = RunnerActivity.CurrentActivity;
	
	public void copy(File src, File dst) throws Exception 
	{
		FileInputStream inStream = new FileInputStream(src);
		FileOutputStream outStream = new FileOutputStream(dst);
		FileChannel inChannel = inStream.getChannel();
		FileChannel outChannel = outStream.getChannel();
		inChannel.transferTo(0, inChannel.size(), outChannel);
		Log.i("yoyo","File Size: " + String.valueOf(inChannel.size()));
		inStream.close();
		outStream.close();
	}

    public double MobileUtils_Share_Open(String Title_text,String MIME,String value)
	{
		StrictMode.VmPolicy.Builder builder = new StrictMode.VmPolicy.Builder();
		StrictMode.setVmPolicy(builder.build());
		
        Intent i = new Intent();
        i.setAction(Intent.ACTION_SEND);
		i.setType(MIME);
		
		switch(MIME)
		{
			case "text/plain":
			case "text/rtf":
			case "text/html":
			case "text/json":
				i.putExtra(Intent.EXTRA_TEXT, value);
			break;
			
			default:
	
				boolean permission = false;
				if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) 
				{
					if(Environment.isExternalStorageManager())
						permission = true;
				} 
				else 
				{
					if(ContextCompat.checkSelfPermission(RunnerActivity.CurrentActivity,Manifest.permission.READ_EXTERNAL_STORAGE) == 0)
					if(ContextCompat.checkSelfPermission(RunnerActivity.CurrentActivity,Manifest.permission.WRITE_EXTERNAL_STORAGE) == 0)
						permission = true;
				}
				
				if(!permission)
					return 0.0;
	
				File localFile = new File(activity.getFilesDir()+"/"+value);
				File extFile = new File(String.valueOf(Environment.getExternalStorageDirectory())+"/"+value);
				
				try
				{
					copy(localFile,extFile);
				}
				catch(Exception e)
				{
					Log.i("yoyo","something wrong");
					return -2.0;
				}
				
				Uri uriFile;
				if(MIME.equals("application/pdf") || MIME.equals("*/*"))
					uriFile = FileProvider.getUriForFile(activity, activity.getPackageName(), extFile);
				else
					uriFile = Uri.fromFile(extFile);				
				
				
				i.putExtra(Intent.EXTRA_STREAM, uriFile);
			break;
		}
        
		i.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        activity.startActivity(Intent.createChooser(i,Title_text));
		
		return 1.0;
    }	
}

