import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class AppCheckBoxField extends FormField<bool> {
  AppCheckBoxField({
    super.key,
    required String title,
    required Function(bool) onChanged,
    bool initialValue = false,
    String? errorText,
  }) : super(
         initialValue: initialValue,
         validator: (value) {
           if (value != true) {
             return errorText;
           }
           return null;
         },
         builder: (field) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CheckboxListTile(
                 value: field.value ?? false,
                 onChanged: (v) {
                   field.didChange(v ?? false);
                   onChanged(v ?? false);
                 },
                 title: Text(title),
                 activeColor: AppColors.PrimaryBlue,
                 contentPadding: const EdgeInsets.only(left: 5),
               ),

               if (field.hasError)
                 Padding(
                   padding: const EdgeInsets.only(left: 12, bottom: 5),
                   child: Text(
                     field.errorText!,
                     style: const TextStyle(color: AppColors.Danger, fontSize: 12),
                   ),
                 ),
             ],
           );
         },
       );
}
