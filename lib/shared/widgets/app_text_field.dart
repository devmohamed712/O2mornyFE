import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;
  final TextInputType? keyboardType;
  final Function(String) onValidated;
  final String? serverError;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.keyboardType,
    required this.onValidated,
    this.serverError,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      cursorColor: AppColors.PrimaryBlue,
      decoration: InputDecoration(
        labelText: label,

        labelStyle: const TextStyle(color: AppColors.PrimaryBlue),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.PrimaryBlue),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.PrimaryGold, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),

        errorText: serverError,
      ),
      onChanged: onChanged,
      validator: (v) => onValidated(v!),
    );
  }
}
