import 'package:parking/const/text.dart';
import 'package:flutter/material.dart';

showMyDialog(context, title, message, onOkPressed) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title, style: AppTextStyle.smallBoldText),
        content: Text(message, style: AppTextStyle.tinyBoldText),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok', style: AppTextStyle.tinyBoldBlueText),
            onPressed: onOkPressed,
          ),
          TextButton(
            child: const Text('Cancel', style: AppTextStyle.tinyBoldBlueText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
