import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/User.dart';
import 'package:expanse_manager/app/themes/textTheme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../views/screens/splash_page.dart';

class AboutPageController extends GetxController {
  Rx<User> user = User().obs;
  Rx<bool> loading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    loading(true);
    var box = await Hive.openBox(hiveBox);
    if (box.get(authUserKey) != null) {
      user.value = box.get(authUserKey);
    }
    loading(false);
  }

  void changeTheme() async {
    var box = await Hive.openBox(hiveBox);
    var themeString = box.get(themeKey);
    if (themeString != null) {
      if (themeString == 'dark') {
        _changeToLight(box);
      } else {
        _changeToDark(box);
      }
    } else {
      if (MediaQuery.of(Get.context!).platformBrightness == Brightness.dark) {
        _changeToLight(box);
      } else {
        _changeToDark(box);
      }
    }
  }

  void _changeToDark(Box box) {
    print("set to dark");
    box.put(themeKey, 'dark');
    Get.changeTheme(FlexThemeData.dark(
      scheme: FlexScheme.rosewood,
      textTheme: myBaseTextTheme,
    ));
  }

  void _changeToLight(Box box) {
    print("set to light");
    box.put(themeKey, 'light');
    Get.changeTheme(FlexThemeData.light(
      scheme: FlexScheme.rosewood,
      textTheme: myBaseTextTheme,
    ));
  }

  void logout() async {
    loading(true);
    var box = await Hive.openBox(hiveBox);
    box.delete(authUserKey);
    box.delete(isauthKey);
    box.delete(authToken);
    loading(false);
    Get.offAll(const SplashPage());
  }
}
