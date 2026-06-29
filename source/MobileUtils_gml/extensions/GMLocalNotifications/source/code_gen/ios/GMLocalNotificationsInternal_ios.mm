// ##### extgen :: Auto-generated file do not edit!! #####

#import <objc/runtime.h>
#import "core/GMExtUtils.h"
#import "GMLocalNotificationsInternal_ios.h"


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

@interface GMLocalNotificationsInternal ()
{
    gm::runtime::DispatchQueue __dispatch_queue;
    id<GMLocalNotificationsInterface> __impl;
}@end


@implementation GMLocalNotificationsInternal

+ (void)load
{
    // Find all loaded classes
    int num = objc_getClassList(NULL, 0);
    if (num <= 0) return;

    Class *classes = (Class *)malloc(sizeof(Class) * (unsigned)num);
    num = objc_getClassList(classes, num);

    Class base = [GMLocalNotificationsInternal class];

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
        __impl = (id<GMLocalNotificationsInterface>)self;
    }
    return self;
}
- (double)__EXT_NATIVE__mobile_utils_notification_create:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: identifier, type: String
    std::string_view identifier = gm::wire::codec::readValue<std::string_view>(__br);

    // field: seconds, type: Float64
    double seconds = gm::wire::codec::readValue<double>(__br);

    // field: title, type: String
    std::string_view title = gm::wire::codec::readValue<std::string_view>(__br);

    // field: message, type: String
    std::string_view message = gm::wire::codec::readValue<std::string_view>(__br);

    // field: data, type: String
    std::string_view data = gm::wire::codec::readValue<std::string_view>(__br);

    [__impl mobile_utils_notification_create:identifier seconds:seconds title:title message:message data:data];

    return 0;
}

- (double)__EXT_NATIVE__mobile_utils_notification_create_ext:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: identifier, type: String
    std::string_view identifier = gm::wire::codec::readValue<std::string_view>(__br);

    // field: seconds, type: Float64
    double seconds = gm::wire::codec::readValue<double>(__br);

    // field: title, type: String
    std::string_view title = gm::wire::codec::readValue<std::string_view>(__br);

    // field: message, type: String
    std::string_view message = gm::wire::codec::readValue<std::string_view>(__br);

    // field: data, type: String
    std::string_view data = gm::wire::codec::readValue<std::string_view>(__br);

    // field: image_path, type: String
    std::string_view image_path = gm::wire::codec::readValue<std::string_view>(__br);

    [__impl mobile_utils_notification_create_ext:identifier seconds:seconds title:title message:message data:data image_path:image_path];

    return 0;
}

- (double)__EXT_NATIVE__mobile_utils_notification_cancel:(char*)identifier
{
    [__impl mobile_utils_notification_cancel:identifier];

    return 0;
}

- (double)__EXT_NATIVE__mobile_utils_notification_set_listener:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl mobile_utils_notification_set_listener:callback];

    return 0;
}

- (double)__EXT_NATIVE__mobile_utils_notification_request_permission:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl mobile_utils_notification_request_permission:callback];

    return 0;
}

- (double)__EXT_NATIVE__mobile_utils_notification_permission_status:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl mobile_utils_notification_permission_status:callback];

    return 0;
}

// Internal function used for fetching dispatched function calls to GML
- (double)__EXT_NATIVE__GMLocalNotifications_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length
{
    gm::byteio::BufferWriter __bw{ __ret_buffer, static_cast<size_t>(__ret_buffer_length) };
    return __dispatch_queue.fetch(__bw);
}

@end

