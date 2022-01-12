import 'dart:async';

import 'package:expanse_manager/views/screens/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  Rx<bool> loading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    validate();
  }

  void validate() {
    loading(true);

    Timer(Duration(seconds: 5), () => loading(false));
  }

  void goToSignInPage() {
    Get.offAll(SignInPage());
  }
}
