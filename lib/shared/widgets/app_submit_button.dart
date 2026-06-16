import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class AppSubmitButton extends StatefulWidget {
  final bool isSubmitting;
  final String text;
  final VoidCallback onPressed;

  const AppSubmitButton({
    super.key,
    required this.isSubmitting,
    required this.text,
    required this.onPressed,
  });

  @override
  State<AppSubmitButton> createState() => AppSubmitButtonState();
}

class AppSubmitButtonState extends State<AppSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: widget.isSubmitting ? null : widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.PrimaryBlue,
          foregroundColor: AppColors.PrimaryGold,

          disabledBackgroundColor: AppColors.PrimaryBlue,
          disabledForegroundColor: AppColors.PrimaryGold,

          overlayColor: Colors.transparent,

          elevation: 0,
          shadowColor: Colors.transparent,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: widget.isSubmitting
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.PrimaryGold,
                ),
              )
            : Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
      ),
    );
  }
}
