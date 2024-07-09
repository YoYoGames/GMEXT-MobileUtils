package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import android.util.Log;

import android.os.Vibrator;
import android.os.VibrationEffect;

import android.app.Activity;

public class MobileUtils_Android_Vibrate extends RunnerSocial
{
	
	Activity activity = RunnerActivity.CurrentActivity;
	
	public void MobileUtils_Android_Vibrate_Predefined(double effectId)
	{
		((Vibrator) activity.getSystemService(Activity.VIBRATOR_SERVICE)).vibrate(VibrationEffect.createPredefined((int) effectId));
	}

	public void MobileUtils_Android_Vibrate_Shot(double milliseconds,double amplitude)
	{
		((Vibrator) activity.getSystemService(Activity.VIBRATOR_SERVICE)).vibrate(VibrationEffect.createOneShot((long)milliseconds,(int)amplitude));

	}
}

