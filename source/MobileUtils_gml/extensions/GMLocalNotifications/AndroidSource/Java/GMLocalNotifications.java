package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.LocalNotificationReceiver;
import ${YYAndroidPackageName}.NotificationCallback;
import ${YYAndroidPackageName}.NotificationData;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.enums.MobileUtilsNotificationPermission;

import android.Manifest;
import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.app.NotificationChannel;
import android.app.NotificationManager;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationManagerCompat;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;

/**
 * Extension Generator conversion of MobileUtils_LocalNotifications.
 *
 * The legacy YYLocalNotifications reported notification arrival through the async
 * Social event. This version returns it through a registered GMFunction listener:
 *
 *     set_listener(callback) -> callback(identifier, title, message, data, image_path)
 *
 * Notifications that arrive before a listener is registered (e.g. a tap that
 * cold-started the app) are queued and flushed when set_listener is called.
 */
public class GMLocalNotifications extends GMLocalNotificationsInternal implements NotificationCallback {

    public static final String DEFAULT_CHANNEL_ID = "GMLocalNotification";

    private static final int NOTIFICATION_PERMISSION_REQUEST_CODE = 0x4E4F; // 'NO'

    // Persistent listener invoked every time a local notification is received/tapped.
    private static volatile GMFunction g_listener = null;

    // Notifications received before a listener is registered are queued here and
    // flushed once a listener is set.
    private static final ArrayList<NotificationData> g_pending = new ArrayList<>();

    // One-shot callback for an in-flight POST_NOTIFICATIONS permission request.
    private GMFunction permissionCallback = null;

    public GMLocalNotifications() {
        LocalNotificationReceiver.registerCallback(this);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
            setupChannels();
    }

    // ----- Lifecycle -----

    public void onStart() {
        Activity activity = RunnerActivity.CurrentActivity;
        Intent intent = activity.getIntent();

        final NotificationData notificationData = NotificationData.fromIntent(intent);
        if (notificationData == null) {
            return;
        }

        Handler handler = new Handler(Looper.getMainLooper());
        handler.postDelayed(() -> {
            onNotificationReceived(notificationData);

            // Clear the notification data from the Intent so it's not processed again
            NotificationData.clearFromIntent(intent);
        }, 1000);
    }

    public void onResume() {
        LocalNotificationReceiver.registerCallback(this);
    }

    public void onPause() {
        LocalNotificationReceiver.unregisterCallback(this);
    }

    public void onStop() {
        LocalNotificationReceiver.unregisterCallback(this);
    }

    public void onDestroy() {
        LocalNotificationReceiver.unregisterCallback(this);
    }

    public void onNewIntent(Intent intent) {
        final NotificationData notificationData = NotificationData.fromIntent(intent);
        if (notificationData == null) {
            return;
        }

        Handler handler = new Handler(Looper.getMainLooper());
        handler.postDelayed(() -> {
            onNotificationReceived(notificationData);
        }, 500);
    }

    // ----- Generator API -----

    public void mobile_utils_notification_create(String identifier, double seconds, String title, String message, String data) {
        mobile_utils_notification_create_ext(identifier, seconds, title, message, data, null);
    }

    public void mobile_utils_notification_create_ext(String identifier, double seconds, String title, String message, String data, String imagePath) {
        if (seconds <= 0)
            return;

        long fireTimeMs = System.currentTimeMillis() + (long) (seconds * 1000.0);

        Activity activity = RunnerActivity.CurrentActivity;
        if (activity == null)
            return;

        Intent intent = new Intent(activity, LocalNotificationReceiver.class);
        NotificationData notificationData = new NotificationData(identifier, title, message, data, imagePath);
        notificationData.toIntent(intent);

        PendingIntent pendingIntent = PendingIntent.getBroadcast(
                activity,
                NotificationData.getUniqueInteger(identifier),
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE
        );
        AlarmManager am = (AlarmManager) activity.getSystemService(Context.ALARM_SERVICE);
        am.set(AlarmManager.RTC_WAKEUP, fireTimeMs, pendingIntent);
    }

    public void mobile_utils_notification_cancel(String identifier) {
        Activity activity = RunnerActivity.CurrentActivity;
        if (activity == null)
            return;

        Context appContext = activity.getApplicationContext();
        Intent intent = new Intent(appContext, LocalNotificationReceiver.class);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(
                appContext,
                NotificationData.getUniqueInteger(identifier),
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE
        );
        pendingIntent.cancel();

        AlarmManager am = (AlarmManager) appContext.getSystemService(Context.ALARM_SERVICE);
        am.cancel(pendingIntent);
    }

    public void mobile_utils_notification_set_listener(GMFunction callback) {
        g_listener = callback;

        // Deliver any notifications that arrived before the listener was
        // registered (e.g. a notification tap that cold-started the app).
        ArrayList<NotificationData> pending;
        synchronized (g_pending) {
            if (g_pending.isEmpty())
                return;
            pending = new ArrayList<>(g_pending);
            g_pending.clear();
        }

        for (NotificationData nd : pending) {
            deliver(callback, nd);
        }
    }

    // Requests the POST_NOTIFICATIONS runtime permission on Android 13+ (API 33).
    // On older versions there is no runtime permission, so the effective state from
    // the system settings is reported instead. callback(granted, error).
    public void mobile_utils_notification_request_permission(GMFunction callback) {
        final Activity activity = RunnerActivity.CurrentActivity;
        if (activity == null) {
            callback.call(false, "Activity is null.");
            return;
        }

        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
            boolean enabled = NotificationManagerCompat.from(activity).areNotificationsEnabled();
            callback.call(enabled, enabled ? "" : "Notifications are disabled in system settings.");
            return;
        }

        if (ContextCompat.checkSelfPermission(activity, Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED) {
            callback.call(true, "");
            return;
        }

        if (permissionCallback != null) {
            callback.call(false, "A permission request is already active.");
            return;
        }

        permissionCallback = callback;

        activity.runOnUiThread(() ->
            activity.requestPermissions(
                new String[]{ Manifest.permission.POST_NOTIFICATIONS },
                NOTIFICATION_PERMISSION_REQUEST_CODE
            )
        );
    }

    // callback(status) where status is a MobileUtilsNotificationPermission value.
    public void mobile_utils_notification_permission_status(GMFunction callback) {
        final Activity activity = RunnerActivity.CurrentActivity;
        if (activity == null) {
            callback.call(MobileUtilsNotificationPermission.Unknown.value());
            return;
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (ContextCompat.checkSelfPermission(activity, Manifest.permission.POST_NOTIFICATIONS) == PackageManager.PERMISSION_GRANTED) {
                callback.call(MobileUtilsNotificationPermission.Authorized.value());
            } else if (activity.shouldShowRequestPermissionRationale(Manifest.permission.POST_NOTIFICATIONS)) {
                // Requested before and denied (rationale should be shown).
                callback.call(MobileUtilsNotificationPermission.Denied.value());
            } else {
                // Either never requested, or permanently denied ("Don't ask again").
                callback.call(MobileUtilsNotificationPermission.NotDetermined.value());
            }
            return;
        }

        boolean enabled = NotificationManagerCompat.from(activity).areNotificationsEnabled();
        callback.call(enabled
            ? MobileUtilsNotificationPermission.Authorized.value()
            : MobileUtilsNotificationPermission.Denied.value());
    }

    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        if (requestCode != NOTIFICATION_PERMISSION_REQUEST_CODE)
            return;

        boolean granted = grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED;

        GMFunction callback = permissionCallback;
        permissionCallback = null;

        if (callback != null)
            callback.call(granted, granted ? "" : "Notification permission was denied.");
    }

    @Override
    public boolean onNotificationReceived(final NotificationData notificationData) {

        // If app is not running or is suspended don't do anything (let the
        // receiver post a system notification instead).
        boolean appRunning = (RunnerActivity.CurrentActivity != null && !RunnerActivity.CurrentActivity.mbAppSuspended);
        if (!appRunning) {
            return false;
        }

        // No listener yet (e.g. a tap that cold-started the app). Queue the
        // notification so it is delivered once a listener registers.
        if (g_listener == null) {
            synchronized (g_pending) {
                g_pending.add(notificationData);
            }
            return true;
        }

        deliver(g_listener, notificationData);
        return true;
    }

    private static void deliver(final GMFunction listener, final NotificationData notificationData) {
        if (listener == null || RunnerActivity.CurrentActivity == null)
            return;

        final String imagePath = notificationData.getImagePath();

        RunnerActivity.CurrentActivity.runOnUiThread(() ->
            listener.call(
                notificationData.getId(),
                notificationData.getTitle(),
                notificationData.getMessage(),
                notificationData.getData(),
                imagePath == null ? "" : imagePath
            )
        );
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    private void setupChannels() {
        Activity activity = RunnerActivity.CurrentActivity;

        CharSequence adminChannelName = activity.getString(R.string.default_notification_channel_name);
        String adminChannelDescription = activity.getString(R.string.default_notification_channel_description);

        NotificationChannel adminChannel;
        adminChannel = new NotificationChannel(DEFAULT_CHANNEL_ID, adminChannelName, NotificationManager.IMPORTANCE_HIGH);
        adminChannel.setDescription(adminChannelDescription);
        adminChannel.enableLights(true);
        adminChannel.setLightColor(Color.RED);
        adminChannel.enableVibration(true);

        NotificationManager notificationManager = (NotificationManager) activity.getSystemService(Context.NOTIFICATION_SERVICE);
        if (notificationManager != null)
            notificationManager.createNotificationChannel(adminChannel);
    }
}
