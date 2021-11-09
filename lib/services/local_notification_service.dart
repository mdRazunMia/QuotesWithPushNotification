import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _flutterNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _flutterNotificationPlugin.initialize(initializationSettings);
  }

//for display the data when app in the foreground
  static void display(RemoteMessage message) {
    try {
      final id = DateTime.now().microsecondsSinceEpoch ~/
          1000; // ~/ is used for integer division

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "pushNotificationTest",
        "pushNotificationTest channel",
        importance: Importance.max,
        priority: Priority.high,
      ));

      _flutterNotificationPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

//This file is for heads up notification displaying purpose when the app in the foreground