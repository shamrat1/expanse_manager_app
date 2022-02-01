
import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/User.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AboutPageController extends GetxController{
Rx<User> user = User().obs;
  @override
  void onInit() async {
    super.onInit();

    var box = await Hive.openBox(hiveBox);
    user.value = box.get(authUserKey);
  }
}