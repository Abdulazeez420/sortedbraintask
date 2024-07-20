// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sortedbraintask/app/modules/home/controllers/notification_controller.dart';
import 'package:sortedbraintask/app/routes/app_pages.dart';
import 'package:sortedbraintask/app/routes/deeplink.dart';
import 'package:sortedbraintask/app/service/notification_service.dart';
import 'package:sortedbraintask/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initUniLinks();
    Get.put(NotificationController());
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SortedBrain Task',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
