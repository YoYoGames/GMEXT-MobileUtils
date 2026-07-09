// ##### extgen :: Auto-generated file do not edit!! #####

#import <objc/runtime.h>
#import "core/GMExtUtils.h"
#import "GMMobileUtilsMicrophoneInternal_ios.h"


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

@interface GMMobileUtilsMicrophoneInternal ()
{
    gm::runtime::DispatchQueue __dispatch_queue;
    id<GMMobileUtilsMicrophoneInterface> __impl;
}@end


@implementation GMMobileUtilsMicrophoneInternal

+ (void)load
{
    // Find all loaded classes
    int num = objc_getClassList(NULL, 0);
    if (num <= 0) return;

    Class *classes = (Class *)malloc(sizeof(Class) * (unsigned)num);
    num = objc_getClassList(classes, num);

    Class base = [GMMobileUtilsMicrophoneInternal class];

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
        __impl = (id<GMMobileUtilsMicrophoneInterface>)self;
    }
    return self;
}
- (double)__EXT_NATIVE__mobile_utils_mic_request
{
    [__impl mobile_utils_mic_request];

    return 0;
}

- (double)__EXT_NATIVE__mobile_utils_mic_check:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl mobile_utils_mic_check:callback];

    return 0;
}

// Internal function used for fetching dispatched function calls to GML
- (double)__EXT_NATIVE__GMMobileUtilsMicrophone_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length
{
    gm::byteio::BufferWriter __bw{ __ret_buffer, static_cast<size_t>(__ret_buffer_length) };
    return __dispatch_queue.fetch(__bw);
}

@end

