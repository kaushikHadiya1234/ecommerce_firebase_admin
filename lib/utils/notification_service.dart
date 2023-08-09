import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class NotificationHelper {
  static final notificationHelper = NotificationHelper();

  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initnotification() async {
    AndroidInitializationSettings android =
        AndroidInitializationSettings('logo');
    DarwinInitializationSettings ios = DarwinInitializationSettings();

    InitializationSettings initializationSettings =
        InitializationSettings(android: android, iOS: ios);

    await notificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> showSimplenotification() async {
    AndroidNotificationDetails androidDetail = AndroidNotificationDetails(
        '1', 'simple',
        priority: Priority.high, importance: Importance.high);
    DarwinNotificationDetails iOSDetail = DarwinNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetail, iOS: iOSDetail);

    await notificationsPlugin.show(
        1, 'Flutter notification testing', 'local', notificationDetails);
  }

  Future<void> timenotification() async {
    AndroidNotificationDetails androidDetail = AndroidNotificationDetails(
        '2', 'easy',
        sound: RawResourceAndroidNotificationSound('my'),
        priority: Priority.high,
        importance: Importance.high);
    DarwinNotificationDetails iOSDetail = DarwinNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetail, iOS: iOSDetail);

    await notificationsPlugin.zonedSchedule(
        3,
        'Flutter notification testing',
        'successfully',
        tz.TZDateTime.now(tz.local).add(
          Duration(seconds: 3),
        ),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showBigPictureNotification() async {
    Uint8List img = await _getByteArrayFromUrl(
        'https://www.indianbarcode.com/images/product/1825.jpg');
    ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(img);

    BigPictureStyleInformation big = BigPictureStyleInformation(bigPicture);

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        '5', 'big',
        priority: Priority.max,
        importance: Importance.high,
        styleInformation: big);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    notificationsPlugin.show(
        7, 'hk digital', 'mega offer sale', notificationDetails);
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }


  Future<void> fireSimpleNotification(title, body) async {
    AndroidNotificationDetails androidDetail = AndroidNotificationDetails(
        '6', 'fire',
        priority: Priority.high, importance: Importance.high);
    DarwinNotificationDetails iOSDetail = DarwinNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetail, iOS: iOSDetail);

    await notificationsPlugin.show(
        1, '$title', '$body', notificationDetails);
  }

}
