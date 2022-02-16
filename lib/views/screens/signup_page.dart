import 'package:expanse_manager/app/controllers/SignUpController.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpController controller = Get.put(SignUpController());

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
                child: Center(
                  child: FittedBox(
                    child: Container(
                      width: Get.width * 0.9,
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(16),
                            child: const Text(
                              "Expense Manager | Registration",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.nameController,
                            decoration: const InputDecoration(
                              label: Text("Name"),
                              border: OutlineInputBorder(),
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller:
                                controller.passwordConfirmationController,
                            decoration: const InputDecoration(
                              label: Text("Password Confirmation"),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              "By signing up, you are agreed to the Terms & Conditions of Expanse Manager",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0x907e7e7e),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              controller.signup();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 30,
                              ),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        offset: Offset(1, 1)),
                                  ]),
                              child: const Text(
                                "Register",
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
                              text: "Already Have An Account?",
                              style: const TextStyle(
                                color: Color(0x707e7e7e),
                              ),
                              children: [
                                TextSpan(
                                  text: " Login",
                                  style: const TextStyle(
                                    color: Color(0xff7e7e7e),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => controller.goToSignInPage(),
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
