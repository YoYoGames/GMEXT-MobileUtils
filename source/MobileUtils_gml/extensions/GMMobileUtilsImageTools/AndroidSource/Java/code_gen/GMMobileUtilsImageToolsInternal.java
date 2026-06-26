// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};

import java.nio.ByteBuffer;
import java.util.*;
import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;

public abstract class GMMobileUtilsImageToolsInternal extends RunnerSocial implements GMMobileUtilsImageToolsInterface {

    public double __EXT_NATIVE__mobile_utils_image_width(String path)
    {
        double __result = mobile_utils_image_width(path);
        return (double)__result;
    }

    public double __EXT_NATIVE__mobile_utils_image_height(String path)
    {
        double __result = mobile_utils_image_height(path);
        return (double)__result;
    }

    public double __EXT_NATIVE__mobile_utils_image_resize(String path, double width, double height)
    {
        boolean __result = mobile_utils_image_resize(path, (double)width, (double)height);
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__mobile_utils_image_crop(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: path, type: String
        String path = GMExtWire.readString(__arg_buffer);

        // field: width, type: Float64
        double width = GMExtWire.readF64(__arg_buffer);

        // field: height, type: Float64
        double height = GMExtWire.readF64(__arg_buffer);

        // field: offset_x, type: Float64
        double offset_x = GMExtWire.readF64(__arg_buffer);

        // field: offset_y, type: Float64
        double offset_y = GMExtWire.readF64(__arg_buffer);

        boolean __result = mobile_utils_image_crop(path, width, height, offset_x, offset_y);
        return __result ? 1.0 : 0.0;
    }

}