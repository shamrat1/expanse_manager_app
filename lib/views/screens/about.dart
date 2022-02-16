import 'package:expanse_manager/app/controllers/AboutPageController.dart';
import 'package:expanse_manager/views/screens/signin_page.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:expanse_manager/views/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  AboutPageController controller = Get.put(AboutPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getCustomAppBar(title: "About"),
        body: Obx(
          () => Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.10,
                      child: Center(
                        child: Text(
                          "Hello" +
                              (controller.user.value.email != null
                                  ? (", " + controller.user.value.email!)
                                  : ''),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: Get.height * .45,
                      // decoration: BoxDecoration(
                      //   color: Color(0xffdbdbdb),
                      // ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // for (var i = 0; i < 4; i++)
                            SettingItem(
                                onTap: () => print('change'),
                                title: "Change Password"),
                            SettingItem(
                                onTap: () => print('Rate Expense Manager'),
                                title: "Rate Expense Manager"),
                            SettingItem(
                                onTap: () => controller.changeTheme(),
                                title: "Change Theme"),
                            SettingItem(
                                onTap: () => print('share'), title: "Share"),

                            SettingItem(
                                onTap: () => print('donate'), title: "Donate"),
                            SettingItem(
                                onTap: () => controller.logout(),
                                title: "Logout"),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text("V 1.0.0"),
                  ],
                ),
              ),
              if (controller.loading.value) EMLoading(),
            ],
          ),
        ));
  }
}
