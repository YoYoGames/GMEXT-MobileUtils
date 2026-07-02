package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.NotificationCallback;
import ${YYAndroidPackageName}.NotificationData;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.os.Build;

import androidx.core.app.NotificationCompat;

import java.io.File;
import java.util.Collections;
import java.util.Set;
import java.util.WeakHashMap;

public class LocalNotificationReceiver extends BroadcastReceiver {

    // Thread-safe WeakHashMap of NotificationCallback instances with weak references
    private static final Set<NotificationCallback> callbacks = Collections.newSetFromMap(new WeakHashMap<>());

    public static void registerCallback(NotificationCallback callback) {
        synchronized (callbacks) {
            callbacks.add(callback);
        }
    }

    public static void unregisterCallback(NotificationCallback callback) {
        synchronized (callbacks) {
            callbacks.remove(callback);
        }
    }

    private static final String DEFAULT_CHANNEL_ID = "GMLocalNotification";

    @Override
    public void onReceive(Context context, Intent intent) {

        NotificationData notificationData = NotificationData.fromIntent(intent);
        if (notificationData == null)
            return;

        boolean anyCallbackInvoked = false;

        synchronized (callbacks) {
            for (NotificationCallback callback : callbacks) {
                if (callback != null) {
                    if (callback.onNotificationReceived(notificationData)) {
                        anyCallbackInvoked = true;
                    }
                }
            }
        }

        if (!anyCallbackInvoked) {
            // No valid callbacks; handle notification directly
            handleIntentNotification(context, notificationData);
        }
    }

    private void handleIntentNotification(Context context, NotificationData notificationData) {
        String title = notificationData.getTitle();
        String message = notificationData.getMessage();
        String id = notificationData.getId();
        String imagePath = notificationData.getImagePath();

        Intent resultIntent = context.getPackageManager().getLaunchIntentForPackage(context.getPackageName());
        resultIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        notificationData.toIntent(resultIntent);

        int uniqueId = NotificationData.getUniqueInteger(id);

        PendingIntent resultPendingIntent = PendingIntent.getActivity(
                context,
                uniqueId,
                resultIntent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE
        );

        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(context, DEFAULT_CHANNEL_ID)
                .setSmallIcon(R.drawable.notification_icon)
                .setContentTitle(title)
                .setContentText(message)
                .setContentIntent(resultPendingIntent)
                .setAutoCancel(true);

        if (imagePath != null && !imagePath.isEmpty()) {
            File localFile = new File(context.getFilesDir(), imagePath);
            if (localFile.exists()) {
                // Load bitmap asynchronously to avoid blocking the main thread
                new Thread(() -> {
                    Bitmap bitmap = BitmapFactory.decodeFile(localFile.getAbsolutePath());
                    if (bitmap != null) {
                        notificationBuilder.setLargeIcon(bitmap);
                    }

                    // Show the notification
                    showNotification(context, uniqueId, notificationBuilder);
                }).start();
                // Exit to prevent showing notification twice
                return;
            }
        }

        showNotification(context, uniqueId, notificationBuilder);
    }

    private void showNotification(Context context, int uniqueId, NotificationCompat.Builder notificationBuilder) {
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

        // A scheduled alarm can fire after the app has been killed, waking only
        // this receiver in a fresh process. The extension object (which creates
        // the channel in its constructor) is not instantiated in that path, so on
        // API 26+ posting to a missing channel is silently dropped. Ensure the
        // channel exists here, using the Context the broadcast already provides.
        ensureChannel(context, notificationManager);

        notificationManager.notify(uniqueId, notificationBuilder.build());
    }

    private static void ensureChannel(Context context, NotificationManager notificationManager) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O || notificationManager == null)
            return;

        if (notificationManager.getNotificationChannel(DEFAULT_CHANNEL_ID) != null)
            return;

        CharSequence name = context.getString(R.string.default_notification_channel_name);
        String description = context.getString(R.string.default_notification_channel_description);

        NotificationChannel channel = new NotificationChannel(DEFAULT_CHANNEL_ID, name, NotificationManager.IMPORTANCE_HIGH);
        channel.setDescription(description);
        channel.enableLights(true);
        channel.setLightColor(Color.RED);
        channel.enableVibration(true);

        notificationManager.createNotificationChannel(channel);
    }
}
