import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

///
/// Created by Auro on 25/06/24
///

class AppToastHelper {
  static showToast(String msg) {
    toastification.show(
      title: Text(msg),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
