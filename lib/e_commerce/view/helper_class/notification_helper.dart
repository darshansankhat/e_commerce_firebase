import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static NotificationHelper helper = NotificationHelper._();

  NotificationHelper._();

  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("logo");
    DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    tz.initializeTimeZones();
    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showSimpleNotification() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "1", "Simple Notification",
        priority: Priority.high, importance: Importance.high);
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await notificationsPlugin.show(
        1, "Product Add", "Product Add Successfully", notificationDetails);
  }

  Future<void> timeNotification() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "2", "time notification",
        priority: Priority.high, importance: Importance.high);
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await notificationsPlugin.zonedSchedule(
        2,
        "Time testing",
        "Time Testing Successfully",
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showSoundNotification() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "3", "Sound Notification",
        priority: Priority.high, importance: Importance.high,sound: RawResourceAndroidNotificationSound("pikachu"));
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);
    await notificationsPlugin.show(
        3, "Sound", "Sound Add Successfully", notificationDetails);
  }
}
