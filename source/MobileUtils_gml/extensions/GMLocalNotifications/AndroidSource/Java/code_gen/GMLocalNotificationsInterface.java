// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.enums.*;

public interface GMLocalNotificationsInterface {
    public void mobile_utils_notification_create(String identifier, double seconds, String title, String message, String data);
    public void mobile_utils_notification_create_ext(String identifier, double seconds, String title, String message, String data, String image_path);
    public void mobile_utils_notification_cancel(String identifier);
    public void mobile_utils_notification_set_listener(GMFunction callback);
    public void mobile_utils_notification_request_permission(GMFunction callback);
    public void mobile_utils_notification_permission_status(GMFunction callback);
}