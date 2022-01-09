import 'dart:ui';

import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Sign In"),
      body: Container(
        child: Stack(
          children: [
            Container(
              width: Get.height,
              height: Get.height,
              // color: Colors.red,
              child: Text("Something"),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Center(
                child: Container(
                  width: Get.height * 0.30,
                  height: Get.height * 0.30,
                  child: Lottie.network(
                      "https://assets6.lottiefiles.com/packages/lf20_x62chJ.json"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
