// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};

import java.nio.ByteBuffer;
import java.util.*;
import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.enums.*;

public abstract class GMLocalNotificationsInternal extends RunnerSocial implements GMLocalNotificationsInterface {

    private final GMExtWire.DispatchQueue __dispatch_queue = new GMExtWire.DispatchQueue();
    public double __EXT_NATIVE__GMLocalNotifications_invocation_handler(ByteBuffer __ret_buffer, double __ret_buffer_length)
    {
        return __dispatch_queue.fetch(__ret_buffer);
    }

    public double __EXT_NATIVE__mobile_utils_notification_create(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: identifier, type: String
        String identifier = GMExtWire.readString(__arg_buffer);

        // field: seconds, type: Float64
        double seconds = GMExtWire.readF64(__arg_buffer);

        // field: title, type: String
        String title = GMExtWire.readString(__arg_buffer);

        // field: message, type: String
        String message = GMExtWire.readString(__arg_buffer);

        // field: data, type: String
        String data = GMExtWire.readString(__arg_buffer);

        mobile_utils_notification_create(identifier, seconds, title, message, data);
        return 0;
    }

    public double __EXT_NATIVE__mobile_utils_notification_create_ext(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: identifier, type: String
        String identifier = GMExtWire.readString(__arg_buffer);

        // field: seconds, type: Float64
        double seconds = GMExtWire.readF64(__arg_buffer);

        // field: title, type: String
        String title = GMExtWire.readString(__arg_buffer);

        // field: message, type: String
        String message = GMExtWire.readString(__arg_buffer);

        // field: data, type: String
        String data = GMExtWire.readString(__arg_buffer);

        // field: image_path, type: String
        String image_path = GMExtWire.readString(__arg_buffer);

        mobile_utils_notification_create_ext(identifier, seconds, title, message, data, image_path);
        return 0;
    }

    public double __EXT_NATIVE__mobile_utils_notification_cancel(String identifier)
    {
        mobile_utils_notification_cancel(identifier);
        return 0;
    }

    public double __EXT_NATIVE__mobile_utils_notification_set_listener(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        mobile_utils_notification_set_listener(callback);
        return 0;
    }

    public double __EXT_NATIVE__mobile_utils_notification_request_permission(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        mobile_utils_notification_request_permission(callback);
        return 0;
    }

    public double __EXT_NATIVE__mobile_utils_notification_permission_status(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        mobile_utils_notification_permission_status(callback);
        return 0;
    }

}