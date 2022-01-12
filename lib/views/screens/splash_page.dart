import 'package:expanse_manager/app/controllers/SplashController.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(
        () => Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (controller.loading.value) EMLoading(),
              EMLoading(),
              Positioned(
                top: (Get.height / 2) - 100,
                child: const Text("Expanse Manager"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
