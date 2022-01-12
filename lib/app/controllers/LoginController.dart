import 'dart:async';
import 'dart:convert';

import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/User.dart';
import 'package:expanse_manager/app/services/AuthenticationService.dart';
import 'package:expanse_manager/main.dart';
import 'package:expanse_manager/views/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  Rx<bool> loading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Rx<User> user = User().obs;

  bool _validate() {
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        "Error",
        "Enter a vaild Email",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } else if (!(passwordController.text.length > 7)) {
      Get.snackbar(
        "Error",
        "Password must be 8 or more characters.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }

  void login() async {
    loading(true);
    if (_validate()) {
      var data = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await AuthenticationService().signin(data);

      if (response.statusCode == 200) {
        GetStorage box = GetStorage();
        var decoded = response.body;
        var user = userFromJson(decoded);
        box.write(authUserKey, user);
        box.write(isauthKey, true);
        box.write(authToken, user.token!);
        print(box.read(isauthKey));
        print(box.read(authUserKey));
        print(box.read(authToken));
        Get.snackbar("Success", "Hello ${user.name}, Successfully Logged in.");

        Get.offAll(LandingPage());
      } else if (response.statusCode == 422) {
        Get.snackbar("Error", jsonDecode(response.body)["message"]);
      } else {
        Get.snackbar("Error", "Something Went Wrong. Try Again later.");
      }
    }
    loading(false);
  }

  void goToSignUpPage() {
    Get.offAll(SignUpPage());
  }
}
