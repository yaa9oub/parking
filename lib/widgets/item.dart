import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Item extends StatelessWidget {
  Item({
    Key? key,
    required this.title,
    required this.icon,
    required this.onclick,
    this.width,
    this.height,
  }) : super(key: key);
  String title;
  IconData icon;
  VoidCallback onclick;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 90,
      child: Material(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          onTap: onclick,
          borderRadius: BorderRadius.circular(7),
          splashColor: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: AppColors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: AppTextStyle.smallBoldWhiteText,
                    )
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.white,
                  size: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
