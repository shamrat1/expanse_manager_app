import 'dart:async';

import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/main.dart';
import 'package:expanse_manager/views/screens/signin_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  Rx<bool> loading = false.obs;
  Rx<bool> isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 3), () => redirect());
  }

  void redirect() {
    GetStorage box = GetStorage();
    isAuthenticated(box.read(isauthKey) ?? false);
    print(box.read(isauthKey));
    if (isAuthenticated.value) {
      Get.offAll(() => LandingPage());
    } else {
      Get.offAll(() => const SignInPage());
    }
  }
}
