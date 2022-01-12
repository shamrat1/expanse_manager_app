import 'dart:ui';

import 'package:expanse_manager/app/controllers/LoginController.dart';
import 'package:expanse_manager/app/controllers/SigninController.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Sign In"),
      body: Obx(
        () => Container(
          child: Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                color: Colors.grey.shade100,
                child: Center(
                  child: FittedBox(
                    child: Container(
                      width: Get.width * 0.9,
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            child: const Text(
                              "Expanse Manager | Login",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.passwordController,
                            decoration: const InputDecoration(
                              label: Text("Password"),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                    color: Color(0x907e7e7e),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => controller.login(),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 30,
                              ),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        color: Colors.blueGrey,
                                        offset: Offset(1, 1)),
                                  ]),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // const Text(
                          //   "New Here? Sign Up Now.",
                          //   style: TextStyle(
                          //     color: Color(0x707e7e7e),
                          //   ),
                          // ),
                          RichText(
                            text: TextSpan(
                              text: "New Here?",
                              style: const TextStyle(
                                color: Color(0x707e7e7e),
                              ),
                              children: [
                                TextSpan(
                                  text: " Sign Up",
                                  style: const TextStyle(
                                    color: Color(0xff7e7e7e),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => controller.goToSignUpPage(),
                                ),
                                const TextSpan(
                                  text: " Now",
                                  style: TextStyle(
                                    color: Color(0x707e7e7e),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (controller.loading.value) const EMLoading(),
            ],
          ),
        ),
      ),
    );
  }
}
