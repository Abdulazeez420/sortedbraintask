import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // if (message.notification != null) {
  //   await flutterLocalNotificationsPlugin.show(
  //     message.notification!.hashCode,
  //     message.notification!.title,
  //     message.notification!.body,
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'channel_id',
  //         'channel_name',
  //         channelDescription: 'channel_description',
  //         importance: Importance.high,
  //         priority: Priority.high,
  //       ),
  //       iOS: DarwinNotificationDetails(),
  //     ),
  //     payload: message.data['id'],
  //   );
  // }
}
