// ##### extgen :: Auto-generated file do not edit!! #####

// #####################################################################
// # Macros
// #####################################################################

// #####################################################################
// # Enums
// #####################################################################

enum VibrationAvailability
{
    None = 0,
    Basic = 1,
    HapticEngine = 2
}

enum AndroidVibrationKind
{
    Click = 0,
    DoubleClick = 1,
    Tick = 2,
    HeavyClick = 5
}

enum IOSVibrationKind
{
    ImpactLight = 0,
    ImpactMedium = 1,
    ImpactHeavy = 2,
    ImpactRigid = 3,
    ImpactSoft = 4,
    Selection = 10,
    NotificationWarning = 20,
    NotificationSuccess = 21,
    NotificationError = 22
}

// #####################################################################
// # Constructors
// #####################################################################

// #####################################################################
// # Codecs
// #####################################################################

// #####################################################################
// # Functions
// #####################################################################

// Skipping function vibrate_is_available (no wrapper is required)


// Skipping function vibrate_predefined (no wrapper is required)


// Skipping function vibrate_shot (no wrapper is required)


/// @ignore
function __GMMobileUtilsVibrate_get_decoders()
{
    static __decoders__ = [];
    return __decoders__;
}
/// @ignore
function __GMMobileUtilsVibrate_is_available()
{
    static __available__ = extension_exists("GMMobileUtilsVibrate");
    return __available__;
}
// #####################################################################
// # Exports
// #####################################################################

#export VibrationAvailability, AndroidVibrationKind, IOSVibrationKind
