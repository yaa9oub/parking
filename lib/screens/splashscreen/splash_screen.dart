import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:parking/screens/splashscreen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/assets.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<SplashController>(
          init: SplashController(),
          initState: (_) {},
          builder: (controller) {
            return SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                color: AppColors.backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Image.asset(Assets.logo),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "My-Issatso-Parking",
                          style: AppTextStyle.bigBoldText,
                        ),
                      ],
                    ),
                    const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
