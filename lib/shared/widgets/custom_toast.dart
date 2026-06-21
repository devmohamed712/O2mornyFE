import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class CustomToast {
  static void success(BuildContext context, String message) {
    _show(context, message, Colors.green);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, AppColors.Danger);
  }

  static void _show(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
