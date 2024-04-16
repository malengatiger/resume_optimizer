import 'package:flutter/material.dart';
import 'package:resume_optimizer/util/styles.dart';

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Error',
          style: myTextStyle(
              context, Theme.of(context).primaryColor, 24, FontWeight.w900),
        ),
        content: Text(
          errorMessage,
          style: myTextStyle(
              context, Theme.of(context).primaryColor, 16, FontWeight.normal),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
