import 'package:parking/const/colors.dart';
import 'package:parking/const/text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking/screens/history/history_controller.dart';
import 'package:parking/screens/reservation/reservation_controller.dart';

class DatePicker extends StatefulWidget {
  DatePicker(
      {Key? key,
      this.borderRadius,
      this.bgColor,
      required this.isTime,
      required this.value})
      : super(key: key);
  final double? borderRadius;
  final Color? bgColor;
  final bool isTime;
  String value;
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  selectDate(BuildContext context) async {
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
      widget.value = DateFormat("EEEE, MMMM dd, yyyy").format(selectedDate);
      ReservationController.date =
          DateFormat("EEEE, MMMM dd, yyyy").format(selectedDate);
      HistoryController.date =
          DateFormat("EEEE, MMMM dd, yyyy").format(selectedDate);
      setState(() {});
    }
  }

  selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
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
      selectedTime = picked;
      widget.value = selectedTime.format(context);
      ReservationController.time = selectedTime.format(context);
      HistoryController.time = selectedTime.format(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        if (widget.isTime) {
          selectTime(context);
        } else {
          selectDate(context);
        }
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
            widget.isTime
                ? const Icon(
                    Icons.watch_later,
                  )
                : const Icon(
                    Icons.calendar_month,
                  ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.value,
              style: AppTextStyle.smallThinText,
            )
          ],
        ),
      ),
    );
  }
}
