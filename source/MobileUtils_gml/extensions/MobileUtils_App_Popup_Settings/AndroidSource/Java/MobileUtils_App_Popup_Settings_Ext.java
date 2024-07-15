package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import android.util.Log;

import android.os.Vibrator;
import android.os.VibrationEffect;

import android.app.Activity;

import android.content.Intent;
import android.net.Uri;
import android.provider.Settings;

public class MobileUtils_App_Popup_Settings_Ext extends RunnerSocial
{
	Activity activity = RunnerActivity.CurrentActivity;
	
	public void MobileUtils_AppPopupSettings_Show()
	{
		Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS,Uri.fromParts("package", activity.getPackageName(), null));
		intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		activity.startActivity(intent);
	}
}

