import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/HomeResponse.dart';
import 'package:expanse_manager/app/models/TransactionResponse.dart';
import 'package:expanse_manager/app/services/TransactionService.dart';
import 'package:expanse_manager/app/themes/textTheme.dart';
import 'package:expanse_manager/views/screens/create_transaction.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  Rx<HomeResponse> homeData = HomeResponse().obs;
  @override
  void onInit() {
    super.onInit();

    // get current months overview
    // get recent 5 records
    getHomeData();
  }

  void getHomeData() async {
    loading(true);
    homeData.value = await TransactionService().getHomeData();
    loading(false);
  }

  void gotoNewTransactionPage(String type) async {
    // var box = await Hive.openBox(hiveBox);
    // var themeString = box.get(themeKey);
    // print(themeString);
    // if (themeString != null) {
    //   if (themeString == 'dark') {
    //     box.put(themeKey, 'light');
    //     Get.changeTheme(FlexThemeData.light(
    //       scheme: FlexScheme.rosewood,
    //       textTheme: myBaseTextTheme,
    //     ));
    //   } else {
    //     box.put(themeKey, 'dark');
    //     Get.changeTheme(FlexThemeData.dark(
    //       scheme: FlexScheme.rosewood,
    //       textTheme: myBaseTextTheme,
    //     ));
    //   }
    // } else {
    //   if (MediaQuery.of(Get.context!).platformBrightness == Brightness.dark) {
    //     box.put(themeKey, 'light');
    //     Get.changeTheme(FlexThemeData.light(
    //       scheme: FlexScheme.rosewood,
    //       textTheme: myBaseTextTheme,
    //     ));
    //   } else {
    //     box.put(themeKey, 'dark');
    //     Get.changeTheme(FlexThemeData.dark(
    //       scheme: FlexScheme.rosewood,
    //       textTheme: myBaseTextTheme,
    //     ));
    //   }
    // }

    Get.to(() => CreateTransaction(), arguments: type);
  }
}
