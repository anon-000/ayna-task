import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

///
/// Created by Auro on 25/06/24
///

class AppToastHelper {
  static showToast(String msg, {ToastificationType? type}) {
    toastification.show(
      title: Text(msg),
      autoCloseDuration: const Duration(seconds: 3),
      type: type ?? ToastificationType.info,
    );
  }
}
