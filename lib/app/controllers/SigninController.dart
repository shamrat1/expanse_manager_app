import 'dart:async';

import 'package:expanse_manager/views/screens/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  Rx<bool> loading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    validate();
  }

  void validate() {
    loading(true);

    Timer(Duration(seconds: 5), () => loading(false));
  }

  void goToSignUpPage() {
    Get.to(SignUpPage());
  }
}
