import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key, this.borderRadius, this.bgColor})
      : super(key: key);
  final double? borderRadius;
  final Color? bgColor;
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();

  selectTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 8),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: AppColors.gray, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        selectTime(context);
      },
      child: Container(
        width: size.width,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        decoration: BoxDecoration(
            color: widget.bgColor ?? Colors.white,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10)),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              DateFormat("EEEE, MMMM dd, yyyy").format(selectedDate),
              style: AppTextStyle.smallThinText,
            )
          ],
        ),
      ),
    );
  }
}
