// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};

import java.nio.ByteBuffer;
import java.util.*;
import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.enums.*;

public abstract class GMMobileUtilsMicrophoneInternal extends RunnerSocial implements GMMobileUtilsMicrophoneInterface {

    private final GMExtWire.DispatchQueue __dispatch_queue = new GMExtWire.DispatchQueue();
    public double __EXT_NATIVE__GMMobileUtilsMicrophone_invocation_handler(ByteBuffer __ret_buffer, double __ret_buffer_length)
    {
        return __dispatch_queue.fetch(__ret_buffer);
    }

    public double __EXT_NATIVE__mobile_utils_mic_request()
    {
        mobile_utils_mic_request();
        return 0;
    }

    public double __EXT_NATIVE__mobile_utils_mic_check(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        mobile_utils_mic_check(callback);
        return 0;
    }

}