import 'package:parking/const/text.dart';
import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({Key? key, this.borderRadius, this.bgColor})
      : super(key: key);
  final double? borderRadius;
  final Color? bgColor;
  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String dropdownValue = 'A+';
  List<String> category = [
    'A+',
    'A-',
    'O+',
    'O-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'Inconnue',
  ];

  void dropdownSetter(value) {
    dropdownValue = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      decoration: BoxDecoration(
          color: widget.bgColor ?? Colors.white,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10)),
      child: DropdownButton(
        isExpanded: true,
        value: dropdownValue,
        underline: Container(),
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 30,
        ),
        items: category.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: AppTextStyle.smallThinText,
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          dropdownSetter(newValue);
        },
      ),
    );
  }
}
