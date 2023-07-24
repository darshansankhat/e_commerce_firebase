import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

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
        priority: Priority.high,
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound("pikachu"));
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await notificationsPlugin.show(
        3, "Sound", "Sound Add Successfully", notificationDetails);
  }

  // Future<String> _downloadAndSaveFile(String url, String fileName) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final String filePath = '${directory.path}/$fileName';
  //   final http.Response response = await http.get(Uri.parse(url));
  //   final File file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //   return filePath;
  // }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }


  Future<void> bigPictureNotification() async {

    // String bigPicturePath = await _downloadAndSaveFile(
    //     'https://i.pinimg.com/originals/d7/85/21/d785210502ea6cafd272579506f56b48.jpg', 'bigPicture');

    // BigPictureStyleInformation bigPictureStyleInformation =
    // BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
    //     contentTitle: 'overridden <b>big</b> content title',
    //     htmlFormatContentTitle: true,
    //     summaryText: 'summary <i>text</i>',
    //     htmlFormatSummaryText: true);
    
    Uint8List img = await _getByteArrayFromUrl("https://i.pinimg.com/originals/d7/85/21/d785210502ea6cafd272579506f56b48.jpg");

    ByteArrayAndroidBitmap bigImage = ByteArrayAndroidBitmap(img);

    BigPictureStyleInformation big =
    BigPictureStyleInformation(bigImage,
        contentTitle: 'Imge testing',
        htmlFormatContentTitle: true,
        summaryText: 'product add',
        htmlFormatSummaryText: true);

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "4", "picture Notification",
        priority: Priority.high, importance: Importance.high,styleInformation: big);
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);
    await notificationsPlugin.show(
        4, "Picture Add", "Picture Add Successfully", notificationDetails);
  }
}
