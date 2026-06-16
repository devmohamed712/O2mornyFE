import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class AppCheckBoxField extends StatefulWidget {
  final bool value;
  final String title;
  final Function(bool) onChanged;

  const AppCheckBoxField({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
  });

  @override
  State<AppCheckBoxField> createState() => AppCheckBoxFieldState();
}

class AppCheckBoxFieldState extends State<AppCheckBoxField> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.value,
      onChanged: (v) => widget.onChanged(v ?? false),
      title: Text("${widget.title}"),
      activeColor: AppColors.PrimaryBlue,
      contentPadding: EdgeInsets.only(left: 5),
    );
  }
}
