import 'package:parking/const/assets.dart';
import 'package:parking/const/colors.dart';
import 'package:flutter/material.dart';

class CarSpot extends StatelessWidget {
  const CarSpot({Key? key, required this.isleft, required this.isSelected})
      : super(key: key);
  final bool isleft;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.14,
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(
            width: 4.0,
            color: AppColors.primaryColor,
          ),
          bottom: const BorderSide(
            width: 4.0,
            color: AppColors.primaryColor,
          ),
          right: isleft
              ? BorderSide.none
              : const BorderSide(
                  width: 2.0,
                  color: AppColors.primaryColor,
                ),
          left: isleft
              ? const BorderSide(
                  width: 2.0,
                  color: AppColors.primaryColor,
                )
              : BorderSide.none,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isSelected
            ? Image.asset(Assets.car)
            : Image.asset(
                Assets.car,
                color: AppColors.gray.withOpacity(0.2),
              ),
      ),
    );
  }
}
