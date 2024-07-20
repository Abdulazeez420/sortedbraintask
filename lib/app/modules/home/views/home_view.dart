import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sortedbraintask/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.DETAIL, arguments: {'id': '123'});
              },
              child: const Text('Go to Detail Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.SETTINGS);
              },
              child: const Text('Go to Settings Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
