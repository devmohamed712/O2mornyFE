import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
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
  State<AppTextField> createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.PrimaryBlue,
      decoration: InputDecoration(
        labelText: widget.label,

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
          borderSide: const BorderSide(color: AppColors.Danger),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.Danger, width: 2),
        ),

        errorStyle: const TextStyle(color: AppColors.Danger, fontSize: 12),

        errorText: widget.serverError,
      ),
      onChanged: widget.onChanged,
      validator: (v) => widget.onValidated(v ?? ''),
    );
  }
}
