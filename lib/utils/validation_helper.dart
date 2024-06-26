import 'package:flutter/material.dart';

///
/// Created by Auro on 25/06/24
///

mixin AppFormValidators {
  static String? validateEmpty(dynamic data, BuildContext context) {
    if (data == null) return "*required";
    if (data is String) {
      if (data.toString().trim().isEmpty) return "*required";
    }
    if (data is Iterable || data is Map) {
      if (data.isEmpty) return "*required";
    }
    return null;
  }

  static String? validateStrongPassword(
      String? password, BuildContext context) {
    // Check if password is null or empty
    if (password == null || password.trim().isEmpty) {
      return "Password is required";
    }

    // Check length
    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }

    // Check for uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Password must contain at least one uppercase letter";
    }

    // Check for lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Password must contain at least one lowercase letter";
    }

    // Check for digit
    if (!RegExp(r'\d').hasMatch(password)) {
      return "Password must contain at least one number";
    }

    // Check for special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return "Password must contain at least one special character";
    }

    // If all checks pass, return null (no error)
    return null;
  }

  static String? validateMail(String? email, BuildContext context) {
    if (email == null || email.isEmpty) {
      return 'Email can\'t be empty';
    }

    // Regular expression for validating an email
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validatePhone(String? phone, BuildContext context) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number can\'t be empty';
    }

    // Regular expression for validating a phone number
    final RegExp phoneRegex = RegExp(
      r'^\+?1?\d{9,15}$', // Allows optional + and country code, followed by 9 to 15 digits
    );

    if (!phoneRegex.hasMatch(phone)) {
      return 'Enter a valid phone number';
    }

    return null;
  }
}
