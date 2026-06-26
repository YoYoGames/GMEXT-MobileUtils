// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};

import java.nio.ByteBuffer;
import java.util.*;
import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.enums.*;

public abstract class GMMobileUtilsVibrateInternal extends RunnerSocial implements GMMobileUtilsVibrateInterface {

    public double __EXT_NATIVE__mobile_utils_vibrate_is_available()
    {
        double __result = mobile_utils_vibrate_is_available();
        return (double)__result;
    }

    public double __EXT_NATIVE__mobile_utils_vibrate_predefined(double kind)
    {
        boolean __result = mobile_utils_vibrate_predefined((double)kind);
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__mobile_utils_vibrate_shot(double milliseconds)
    {
        boolean __result = mobile_utils_vibrate_shot((double)milliseconds);
        return __result ? 1.0 : 0.0;
    }

}