@title Extension Options

# Extension Options

Some Mobile Utils modules expose Extension Options that you should review before building. To edit them, open the extension in the GameMaker IDE, expand it in the Asset Browser, double-click the relevant sub-extension and select **Extension Options**. Each option below is filled in per sub-extension.

Most options are iOS usage-description strings (shown to the player when a permission is requested) or the APNs environment. Modules not listed here — Image Tools, Night Mode, Vibration and Settings — have no options to configure.

## Camera

| Option | Type | Default | Description |
|----|----|----|----|
| Camera Usage Description | String | `You can take photos to document your job.` | The text iOS shows when requesting camera access. Injected into the iOS `Info.plist` as `NSCameraUsageDescription`. |

## Gallery

| Option | Type | Default | Description |
|----|----|----|----|
| Photo Usage Description | String | `You can select photos to attach to reports.` | The text iOS shows when requesting photo-library access. Injected as `NSPhotoLibraryUsageDescription`. |

## Share

| Option | Type | Default | Description |
|----|----|----|----|
| Photo Usage Description | String | `Necesary permission if you want save the share image on your device` | The text iOS shows when the player saves a shared image to their library. Injected as `NSPhotoLibraryAddUsageDescription`. |

## Push Notifications (APNs)

| Option | Type | Default | Description |
|----|----|----|----|
| APS Environment | Combo (`development` / `production`) | `development` | The Apple push environment written to the iOS entitlements as `aps-environment`. |

> [!IMPORTANT]
> Set **APS Environment** to `production` for App Store / TestFlight release builds. Leaving it on `development` will break push delivery in release. See ${module.apn}.

## Local Notifications

| Option | Type | Default | Description |
|----|----|----|----|
| APS Environment | Combo (`development` / `production`) | `development` | The Apple push environment written to the iOS entitlements as `aps-environment`. Set to `production` for release builds. |

> [!NOTE]
> The Android notification channel name/description and the notification icon are **not** Extension Options. They are bundled Android resources inside the extension (`AndroidSource/res/values/` for the channel strings and `AndroidSource/res/drawable-*/notification_icon.png` for the icon) — edit those resource files to customise them.

## Microphone

| Option | Type | Default | Description |
|----|----|----|----|
| iOS Mic Access Description | String | `This app needs microphone access for voice chat.` | The text iOS shows when requesting microphone access. Injected into the iOS `Info.plist` as `NSMicrophoneUsageDescription`. |
