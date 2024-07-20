

  import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sortedbraintask/app/routes/app_pages.dart';
import 'package:uni_links/uni_links.dart';

StreamSubscription? sub;
 Future<void> initUniLinks() async {
    try {
      Uri? initialLink = await getInitialUri();
      if (initialLink != null) {
        debugPrint("initialLink----");
        handleDeepLink(initialLink);
      }
    } catch (e) {
      print(e);
    }

    sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleDeepLink(uri);
      }
    }, onError: (err) {
      print(err);
    });
  }

  void handleDeepLink(Uri uri) {
    debugPrint("handleDeepLink----");
    final path = uri.path;
    final id = uri.queryParameters['id'];

    if (path == '/detail' && id != null) {
      Get.toNamed(Routes.DETAIL, arguments: {'id': id});
    }else if (path == '/settings') {
      Get.toNamed(Routes.SETTINGS);
    }
  }
