import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.validator,
    this.iconData,
    this.isPassword,
    this.editingController,
    this.inputType,
    this.inputAction,
    this.borderRadius,
  }) : super(key: key);
  final String label;
  final String hint;
  final IconData? iconData;
  final double? borderRadius;
  final bool? isPassword;
  final TextEditingController? editingController;
  final String? Function(String?) validator;
  final TextInputType? inputType;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      obscureText: isPassword ?? false,
      cursorColor: AppColors.primaryColor,
      validator: validator,
      keyboardType: inputType ?? TextInputType.text,
      textInputAction: inputAction ?? TextInputAction.next,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 21.0, horizontal: 5.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 99999),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.darkGray,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 99999),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.darkGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 99999),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.darkGray,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 99999),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.darkGray,
          ),
        ),
        suffixIcon: iconData != null
            ? Icon(
                iconData,
                color: AppColors.primaryColor,
              )
            : null,
        prefixIcon: const Icon(null),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        labelStyle: AppTextStyle.smallBoldText,
        floatingLabelStyle: AppTextStyle.smallBoldText,
        hintText: hint,
        hintStyle: AppTextStyle.tinyThinText,
      ),
    );
  }
}
