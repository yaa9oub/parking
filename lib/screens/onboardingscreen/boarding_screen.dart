import 'package:parking/const/colors.dart';
import 'package:parking/screens/onboardingscreen/boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardingPage extends GetView<BoardingController> {
  const BoardingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<BoardingController>(
          init: BoardingController(),
          initState: (_) {},
          builder: (controller) {
            return SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                color: AppColors.backgroundColor,
              ),
            );
          }),
    );
  }
}
