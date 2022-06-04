import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:parking/screens/history/history_controller.dart';
import 'package:parking/widgets/buttons.dart';
import 'package:parking/widgets/car_spot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var xSpace = 10.0;
    var ySpace = 20.0;
    return Scaffold(
      body: GetBuilder<HistoryController>(
          init: HistoryController(),
          initState: (_) {},
          builder: (controller) {
            return SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                color: AppColors.backgroundColor,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    //Title
                    const Text(
                      "History",
                      style: AppTextStyle.bigBoldText,
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    SizedBox(
                      height: size.height * 0.75,
                      child: controller.reservations.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: controller.reservations.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.20,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                //Slot
                                                Text(
                                                    "Slot " +
                                                        controller
                                                            .reservations[index]
                                                            .slot
                                                            .toString(),
                                                    style: AppTextStyle
                                                        .smallBoldWhiteText),
                                                SizedBox(
                                                  width: xSpace,
                                                ),
                                                //Status
                                                controller.reservations[index]
                                                        .status
                                                    ? const Icon(
                                                        Icons.done_all,
                                                        color: Colors.green,
                                                      )
                                                    : const Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                              ],
                                            ),
                                            //Date
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Date",
                                                    style: AppTextStyle
                                                        .tinyBoldWhiteText),
                                                Text(
                                                    controller
                                                        .reservations[index]
                                                        .date,
                                                    style: AppTextStyle
                                                        .tinyBoldWhiteText),
                                              ],
                                            ),
                                            //Time
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Time",
                                                    style: AppTextStyle
                                                        .tinyBoldWhiteText),
                                                Text(
                                                    controller
                                                        .reservations[index]
                                                        .time,
                                                    style: AppTextStyle
                                                        .tinyBoldWhiteText),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      //BUTTONS
                                      SizedBox(
                                        width: size.width * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SecondaryButton(
                                              onClick: () {
                                                controller
                                                    .changeReservation(index);
                                              },
                                              title: "Change",
                                              borderRadius: 0,
                                            ),
                                            SecondaryButton(
                                              onClick: () {
                                                controller
                                                    .cancelReservation(index);
                                              },
                                              title: "Cancel",
                                              borderRadius: 0,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              })
                          : Center(
                              child: Text("No reservations 😒😒",
                                  style: AppTextStyle.smallBoldText.copyWith(
                                      color: AppColors.secondaryColor)),
                            ),
                    ),
                  ],
                )),
              ),
            );
          }),
    );
  }
}
