@title Getting Started

# Getting Started

This guide walks you through adding the **Mobile Utils** extension to your project and making your first call. Mobile Utils targets **Android** and **iOS** only.

## Importing the extension

Mobile Utils is a collection of small, independent sub-extensions (Camera, Gallery, Image Tools, Share, Settings, Night Mode, Vibration, Local Notifications and Push Notifications) plus a shared `ExtensionCore`.

> [!IMPORTANT]
> `ExtensionCore` is required — it contains the shared native code every other module depends on. Always import it alongside the modules you use.

Because the features are split into separate modules, you only need to import the ones your game actually uses. This keeps unnecessary permissions and platform capabilities out of your application's manifest — for example, importing only the Vibration module will not add camera or notification permissions to your build.

## Extension options

Some modules expose Extension Options that you must review before building (for example the iOS usage-description strings and the APNs environment). These are described in the ${page.extension_options} guide.

## Working with callbacks

Most Mobile Utils functions are **asynchronous**: rather than returning a result directly, they take a `callback` method that is invoked once the operation finishes. The callback receives its results as positional arguments — typically a leading `success` (or `granted`) boolean, followed by the result values, and an `error` string that is empty on success.

```gml
mobile_utils_camera_open(function(_success, _path, _error)
{
    if (!_success)
    {
        show_debug_message("Camera failed: " + _error);
        return;
    }
    sprite = sprite_add(_path, 1, false, false, 0, 0);
});
```

A few functions are **synchronous** and return their result directly, such as the ${module.image_tools} functions and ${function.mobile_utils_night_mode_check}.

## Platform notes

- Several behaviours differ between Android and iOS (image formats, haptic availability, the notification image path, and push support). Each module page calls these out — read the relevant notes before shipping.
- ${module.apn} is **iOS-only and experimental**; guard those calls with `os_type == os_ios`.
- The device vibration kinds are platform-specific and overlap numerically — always pick the enum member matching the running platform (see ${function.mobile_utils_vibrate_predefined}).

## Testing

Test on real hardware. Cameras, photo libraries, share targets, haptics and notifications behave differently (or are unavailable) on simulators/emulators, and permission prompts only appear on device.

## Next steps

- ${page.extension_options} — the per-module setup values.
- Browse the module pages listed in the sidebar for the full function reference.
