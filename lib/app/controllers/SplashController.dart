import 'dart:async';

import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/main.dart';
import 'package:expanse_manager/views/screens/signin_page.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashController extends GetxController {
  Rx<bool> loading = false.obs;
  Rx<bool> isAuthenticated = false.obs;

  @override
  void onInit() async {
    super.onInit();
    Timer(Duration(seconds: 3), () => redirect());
  }

  void redirect() async {
    // var box = await Hive.openBox(hiveBox);
    var box = await Hive.openBox(hiveBox);
    isAuthenticated(box.get(isauthKey) ?? false);
    if (isAuthenticated.value) {
      Get.offAll(() => LandingPage());
    } else {
      Get.offAll(() => const SignInPage());
    }
  }
}
