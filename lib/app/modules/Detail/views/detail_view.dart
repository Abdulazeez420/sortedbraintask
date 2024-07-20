import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
 Widget build(BuildContext context) {
    final id = Get.arguments['id'];
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Detail Screen with ID: '),
            Text("${id??''}",style: const TextStyle(fontSize: 14,color: Colors.white ),)
          ],
        ),
      ),
    );
  }
}