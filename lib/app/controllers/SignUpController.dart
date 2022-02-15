import 'dart:async';

import 'package:expanse_manager/app/services/AuthenticationService.dart';
import 'package:expanse_manager/views/screens/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  Rx<bool> loading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void validate() {
    loading(true);

  }

  void signup() async {
    loading(true);
    var data = {
      "name" : nameController.text,
      "email" : emailController.text,
      "password" : passwordController.text,
      "password_confirmation" : passwordConfirmationController.text,
    };
    http.Response response = await AuthenticationService().register(data);
    if(response.statusCode == 200){
      Get.offAll(() => SignInPage());
      Get.snackbar( "Success",  "Registration Successful.",);

    }
    loading(false);
  }

  void goToSignInPage() {
    Get.offAll(SignInPage());
  }
}
