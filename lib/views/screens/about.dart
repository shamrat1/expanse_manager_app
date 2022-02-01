import 'package:expanse_manager/app/controllers/AboutPageController.dart';
import 'package:expanse_manager/views/screens/signin_page.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
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
      body: Obx(() => Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.35,
                  child: Center(
                    child: Text(
                      "Hello, User Name",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Get.height * .30,
                  // decoration: BoxDecoration(
                  //   color: Color(0xffdbdbdb),
                  // ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // for (var i = 0; i < 4; i++)
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xffdbdbdb)))),
                          alignment: Alignment.center,
                          // color: Colors.amber,
                          child: const Text(
                            "Change Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          height: Get.height * .06,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xffdbdbdb)))),
                          alignment: Alignment.center,
                          // color: Colors.amber,
                          child: const Text(
                            "Rate Expanse Manager",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          height: Get.height * .06,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xffdbdbdb)))),
                          alignment: Alignment.center,
                          // color: Colors.amber,
                          child: const Text(
                            "Share",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          height: Get.height * .06,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Color(0xffdbdbdb)))),
                          alignment: Alignment.center,
                          // color: Colors.amber,
                          child: const Text(
                            "Donate",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          height: Get.height * .06,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const SignInPage());
                          },
                          child: Container(
                            // decoration: BoxDecoration(
                            //     border: Border(
                            //         bottom: BorderSide(color: Color(0xffdbdbdb)))),
                            alignment: Alignment.center,
                            // color: Colors.amber,
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            height: Get.height * .06,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                const Text("V 1.0.0"),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
