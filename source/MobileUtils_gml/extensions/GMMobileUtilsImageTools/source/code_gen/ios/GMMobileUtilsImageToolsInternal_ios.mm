// ##### extgen :: Auto-generated file do not edit!! #####

#import <objc/runtime.h>
#import "core/GMExtUtils.h"
#import "GMMobileUtilsImageToolsInternal_ios.h"


extern "C" const char* extOptGetString(char* _ext, char* _opt);

// Adapter: matches const signature expected by the C++ API
static const char* ExtOptGetString(const char* ext, const char* opt)
{
    return extOptGetString(const_cast<char*>(ext), const_cast<char*>(opt));
}

static BOOL GMIsSubclassOf(Class cls, Class base)
{
    for (Class c = cls; c != Nil; c = class_getSuperclass(c)) {
        if (c == base) return YES;
    }
    return NO;
}

static void GMInjectSelectorsIntoSubclass(Class subclass, Class base)
{
    // Build set of methods already defined on subclass
    unsigned subCount = 0;
    Method *subList = class_copyMethodList(subclass, &subCount);

    CFMutableSetRef owned = CFSetCreateMutable(kCFAllocatorDefault, 0, NULL);
    for (unsigned i = 0; i < subCount; ++i) {
        CFSetAddValue(owned, method_getName(subList[i]));
    }

    // Walk base class methods
    unsigned baseCount = 0;
    Method *baseList = class_copyMethodList(base, &baseCount);

    for (unsigned i = 0; i < baseCount; ++i) {
        SEL sel = method_getName(baseList[i]);
        const char *name = sel_getName(sel);

        // Only inject extension selectors (methods prefixed with __EXT_NATIVE__)
        if (!name || strncmp(name, "__EXT_NATIVE__", 13) != 0) continue;

        // Add only if subclass doesn't already have it
        if (!CFSetContainsValue(owned, sel)) {
            IMP imp = method_getImplementation(baseList[i]);
            const char *types = method_getTypeEncoding(baseList[i]);
            if (class_addMethod(subclass, sel, imp, types)) {
                CFSetAddValue(owned, sel);
            }
        }
    }

    if (subList) free(subList);
    if (baseList) free(baseList);
    if (owned) CFRelease(owned);
}

@interface GMMobileUtilsImageToolsInternal ()
{
    id<GMMobileUtilsImageToolsInterface> __impl;
}@end


@implementation GMMobileUtilsImageToolsInternal

+ (void)load
{
    // Find all loaded classes
    int num = objc_getClassList(NULL, 0);
    if (num <= 0) return;

    Class *classes = (Class *)malloc(sizeof(Class) * (unsigned)num);
    num = objc_getClassList(classes, num);

    Class base = [GMMobileUtilsImageToolsInternal class];

    for (int i = 0; i < num; ++i) {
        Class cls = classes[i];
        if (cls == base) continue;

        // We only care about direct or indirect subclasses
        if (GMIsSubclassOf(cls, base)) {
            GMInjectSelectorsIntoSubclass(cls, base);
        }
    }

    free(classes);

    gm::details::GMRTRunnerInterface ri{};
    ri.ExtOptGetString = &ExtOptGetString;
    GMExtensionInitialise(&ri, sizeof(ri));
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        __impl = (id<GMMobileUtilsImageToolsInterface>)self;
    }
    return self;
}
- (double)__EXT_NATIVE__mobile_utils_image_width:(char*)path
{
    double __result = [__impl mobile_utils_image_width:path];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__mobile_utils_image_height:(char*)path
{
    double __result = [__impl mobile_utils_image_height:path];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__mobile_utils_image_resize:(char*)path arg1:(double)width arg2:(double)height
{
    bool __result = [__impl mobile_utils_image_resize:path width:static_cast<double>(width) height:static_cast<double>(height)];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__mobile_utils_image_crop:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: path, type: String
    std::string_view path = gm::wire::codec::readValue<std::string_view>(__br);

    // field: width, type: Float64
    double width = gm::wire::codec::readValue<double>(__br);

    // field: height, type: Float64
    double height = gm::wire::codec::readValue<double>(__br);

    // field: offset_x, type: Float64
    double offset_x = gm::wire::codec::readValue<double>(__br);

    // field: offset_y, type: Float64
    double offset_y = gm::wire::codec::readValue<double>(__br);

    bool __result = [__impl mobile_utils_image_crop:path width:width height:height offset_x:offset_x offset_y:offset_y];

    return static_cast<double>(__result);
}

@end

