import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EMLoading extends StatelessWidget {
  const EMLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: BackdropFilter(
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
    );
  }
}
