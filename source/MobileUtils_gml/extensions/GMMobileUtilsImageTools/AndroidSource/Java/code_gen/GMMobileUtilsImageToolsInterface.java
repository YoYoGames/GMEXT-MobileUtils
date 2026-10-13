// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;

public interface GMMobileUtilsImageToolsInterface {
    public double image_width(String path);
    public double image_height(String path);
    public boolean image_resize(String path, double width, double height);
    public boolean image_crop(String path, double width, double height, double offset_x, double offset_y);
}