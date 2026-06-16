import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDatePickerField extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime>? onChanged;
  final Function(String) onValidated;
  final String? serverError;

  const AppDatePickerField({
    super.key,
    this.label = "Date Of Birth",
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.onChanged,
    required this.onValidated,
    this.serverError,
  });

  @override
  State<AppDatePickerField> createState() => AppDatePickerFieldState();
}

class AppDatePickerFieldState extends State<AppDatePickerField> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: _pickDate,
      controller: TextEditingController(
        text: selectedDate == null
            ? ''
            : DateFormat('dd/MM/yyyy').format(selectedDate!),
      ),
      decoration: InputDecoration(
        labelText: widget.label,

        prefixIcon: const Icon(
          Icons.calendar_month_outlined,
          color: AppColors.PrimaryBlue,
        ),

        suffixIcon: const Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.PrimaryBlue,
        ),

        labelStyle: const TextStyle(color: AppColors.PrimaryBlue),

        floatingLabelStyle: const TextStyle(color: AppColors.PrimaryGold),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.PrimaryBlue),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.PrimaryGold, width: 2),
        ),

        errorText: widget.serverError,
      ),
      validator: (v) => widget.onValidated(v!),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.Light,
              headerBackgroundColor: AppColors.Light,
              headerForegroundColor: AppColors.PrimaryBlue,

              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                return AppColors.PrimaryBlue;
              }),

              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.PrimaryGold;
                }
                return null;
              }),

              todayBackgroundColor: WidgetStateProperty.all(AppColors.Light),

              todayBorder: BorderSide(color: AppColors.PrimaryBlue),

              todayForegroundColor: WidgetStateProperty.all(
                AppColors.PrimaryBlue,
              ),

              cancelButtonStyle: TextButton.styleFrom(
                foregroundColor: AppColors.PrimaryBlue,
              ),

              confirmButtonStyle: TextButton.styleFrom(
                foregroundColor: AppColors.PrimaryBlue,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    setState(() {
      selectedDate = picked;
    });

    widget.onChanged?.call(picked);
  }
}
