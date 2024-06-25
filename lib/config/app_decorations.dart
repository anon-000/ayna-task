import 'package:ayna_task/config/app_colors.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 25/06/24
///

mixin AppDecorations {
  static InputDecoration textFieldDecoration(BuildContext context,
      {double radius = 8}) {
    return InputDecoration(
      // fillColor: Colors.grey.shade200,
      filled: false,
      counterText: '',
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade300
                : AppColors.textFieldBorder,
            width: 1.2,
          )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade300
                : AppColors.textFieldBorder,
            width: 1.2,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.2,
          )),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade300
              : AppColors.textFieldBorder,
          width: 1.2,
        ),
      ),
    );
  }
}
