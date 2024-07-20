import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sortedbraintask/app/routes/deeplink.dart';
// import 'package:sortedbraintask/app/service/notification_service.dart';

class NotificationController extends GetxController {
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void onInit() {
    super.onInit();
    _initFirebaseMessaging();
    _initLocalNotifications();
    _handleFirebaseMessaging();
    _getFcmToken();
    initUniLinks();
  }

  void _initFirebaseMessaging() {
    FirebaseMessaging.instance.subscribeToTopic('all');
    FirebaseMessaging.instance.requestPermission();
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  void _initLocalNotifications() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  void _handleFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _showLocalNotification(message);

        // if (message.data.containsKey('deep_link')) {
        // Uri uri = Uri.parse(message.data['id']!);
        // handleDeepLink(uri);
        // } else {
        // Get.snackbar(notification.title!, notification.body!,
        //     snackPosition: SnackPosition.BOTTOM);
        // }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Uri uri = Uri.parse(message.data['id']!);
      handleDeepLink(uri);
    });
  }

  void _showLocalNotification(RemoteMessage message) async {
    await _flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification!.title,
      message.notification!.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_description',
          importance: Importance.high,
          priority: Priority.high,
          showWhen: false,
        ),
        iOS: DarwinNotificationDetails(
          threadIdentifier: 'thread_id',
        ),
      ),
      payload: message.data['id'],
    );
    Get.snackbar(message.notification!.title!, message.notification!.body!,
        snackPosition: SnackPosition.BOTTOM);
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    print("payload: ${notificationResponse.payload}");
    if (notificationResponse.payload != null) {
      Uri uri = Uri.parse(notificationResponse.payload!);
      handleDeepLink(uri);
    }
  }

  void _getFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print("FCM Token: $token");
    } else {
      print("Failed to get FCM token");
    }
  }
}
