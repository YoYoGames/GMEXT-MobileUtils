
package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import android.content.res.Configuration;
import android.util.Log;

import android.app.Activity;

public class MobileUtils_NightMode extends RunnerSocial
{	
	Activity activity = RunnerActivity.CurrentActivity;
	
	public double MobileUtils_NightMode_Check() 
	{
		int nightModeFlags = activity.getResources().getConfiguration().uiMode & Configuration.UI_MODE_NIGHT_MASK;
		switch (nightModeFlags) {
			case Configuration.UI_MODE_NIGHT_YES:
					return 0;

			case Configuration.UI_MODE_NIGHT_NO:
					return 1;

			case Configuration.UI_MODE_NIGHT_UNDEFINED:
					return 2;
				 
				default:
					return 2;
		}
	}
	
}

