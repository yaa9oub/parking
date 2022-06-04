import 'package:parking/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getErrorSnackBar({title: String, message: String}) {
  return Get.snackbar(
    title,
    message,
    borderRadius: 8,
    snackPosition: SnackPosition.TOP,
    isDismissible: true,
    backgroundColor: AppColors.red.withOpacity(0.3),
    margin: const EdgeInsets.all(4),
    colorText: AppColors.white,
    duration: const Duration(milliseconds: 2500),
  );
}

getSuccessSnackBar({title: String, message: String}) {
  return Get.snackbar(
    title,
    message,
    borderRadius: 8,
    snackPosition: SnackPosition.TOP,
    isDismissible: true,
    messageText: Text(
      message,
    ),
    backgroundColor: AppColors.green.withOpacity(0.5),
    margin: const EdgeInsets.all(4),
    colorText: AppColors.white,
    duration: const Duration(milliseconds: 2500),
  );
}
