import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class AppSliderBarField extends FormField<double> {
  AppSliderBarField({
    super.key,
    required String title,
    required ValueChanged<double> onChanged,
    required FormFieldValidator<double> validator,
    double initialValue = 0.0,
  }) : super(
          initialValue: initialValue,
          validator: validator,
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    '$title (${field.value!.toStringAsFixed(1)})',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.Dark,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),

                Slider.adaptive(
                  value: field.value!,
                  min: 0,
                  max: 50,
                  divisions: 500,
                  label: field.value!.toStringAsFixed(1),
                  thumbColor: AppColors.PrimaryBlue,
                  activeColor: AppColors.PrimaryGold,
                  onChanged: (value) {
                    field.didChange(value);
                    onChanged(value);
                  },
                ),

                if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 5),
                    child: Text(
                      field.errorText!,
                      style: const TextStyle(
                        color: AppColors.Danger,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}