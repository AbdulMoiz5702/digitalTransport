import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();
  static initializeNotification() async {
    await plugin.initialize(const InitializationSettings(
      android: AndroidInitializationSettings("@drawable/background"),
      iOS: DarwinInitializationSettings(),
    ));
  }

  static const AndroidNotificationChannel androidChannel =
      AndroidNotificationChannel("transport", 'digitalize_transport',
          description: "Digitalize Transport Description",
          importance: Importance.max,
          playSound: true);

  static AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      androidChannel.id, androidChannel.name,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: "@drawable/background",
      ongoing: true);

  static NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails, iOS: const DarwinNotificationDetails());
}
