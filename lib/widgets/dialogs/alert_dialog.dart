import 'package:flutter/material.dart';
// import 'dart:io';

///
/// Created by Auro on 26/06/24
///

Future<bool?> showAppAlertDialog({
  required BuildContext context,
  String title = '',
  String? description,
  String positiveText = 'Ok',
  String negativeText = 'Cancel',
}) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: description != null ? Text(description) : null,
        actions: [
          TextButton(
            child: Text(negativeText),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text(positiveText),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
