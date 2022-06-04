import 'package:parking/const/assets.dart';
import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:parking/screens/reservation/reservation_controller.dart';
import 'package:parking/widgets/car_spot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationPage extends GetView<ReservationController> {
  const ReservationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var xSpace = 10.0;
    var ySpace = 20.0;
    return Scaffold(
      body: GetBuilder<ReservationController>(
          init: ReservationController(),
          initState: (_) {},
          builder: (controller) {
            return SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                color: AppColors.backgroundColor,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.keyForm,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        //Title
                        SizedBox(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Reservation",
                                style: AppTextStyle.bigBoldText,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(Assets.car)),
                              SizedBox(
                                width: xSpace,
                              ),
                              const Text(
                                  "This icon represents the reserved spots.",
                                  style: AppTextStyle.tinyBoldBlueText),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    Assets.car,
                                    color: AppColors.lightGray,
                                  )),
                              SizedBox(
                                width: xSpace,
                              ),
                              const Text(
                                  "This icon represents the available spots.",
                                  style: AppTextStyle.tinyBoldText),
                            ],
                          ),
                        ),
                        SizedBox(height: ySpace),
                        SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.8,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: controller.parking.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Material(
                                  child: InkWell(
                                    onTap: () {
                                      controller.reserveSpot(index);
                                    },
                                    splashColor:
                                        AppColors.primaryColor.withOpacity(0.3),
                                    child: Stack(
                                      children: [
                                        CarSpot(
                                            isleft: controller
                                                .parking[index].isleft,
                                            isSelected: controller
                                                .parking[index].isSelected),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text((index + 1).toString(),
                                              style:
                                                  AppTextStyle.smallBoldText),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
