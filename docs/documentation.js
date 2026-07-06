
/**
 * @module home
 * @title Mobile Utils
 *
 * @section Extension's Features
 * @desc
 *
 * * Take a photo with the device camera and pick an image from the gallery
 * * Resize and crop images on disk
 * * Present the native share sheet for text and files
 * * Open the application's system settings page
 * * Query the device's light/dark (night) mode
 * * Trigger predefined and custom device vibrations / haptics
 * * Schedule, cancel and listen for local notifications
 * * Register for Apple Push Notifications (APNs) and read the device token
 *
 * @section_end
 *
 * @section Introduction
 *
 * @desc
 *
 * Mobile Utils is a set of helpers offering various device functionality on the mobile platforms **Android** and **iOS**. It is assembled from several small, independent sub-extensions so that a project only pulls in the features (and the associated permissions) that it actually uses.
 *
 * [[Note: To avoid injecting unnecessary permissions into your application's manifest, the functionality is split into distinct modules. Import only the modules your game needs — each one is documented separately below.]]
 *
 * The asynchronous functions (for example ${function.mobile_utils_camera_open} or ${function.mobile_utils_share_open}) do not return their result immediately; instead they take a `callback` method that is invoked once the operation finishes. See the ${page.getting_started} guide for how to work with these callbacks, and ${page.extension_options} for the per-module setup values.
 *
 * @section_end
 *
 * @section Guides
 * @desc The following guides help you set up and start using the extension:
 * @reference page.getting_started
 * @reference page.extension_options
 * @section_end
 *
 * @section Modules
 * @desc The following modules are available under the Mobile Utils extension:
 *
 * @reference module.camera
 * @reference module.gallery
 * @reference module.image_tools
 * @reference module.share
 * @reference module.settings
 * @reference module.nightmode
 * @reference module.vibration
 * @reference module.local_notifications
 * @reference module.apn
 *
 * @section_end
 *
 * @module_end
 */
