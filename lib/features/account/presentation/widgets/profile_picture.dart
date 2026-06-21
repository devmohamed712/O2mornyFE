import 'dart:io';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final File? image;
  final Future<void> Function() onPick;
  final String? errorText;

  const ProfilePicture({
    super.key,
    required this.image,
    required this.onPick,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPick,
          child: CircleAvatar(
            radius: 55,
            backgroundImage: image != null ? FileImage(image!) : null,
            child: image == null
                ? const Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.PrimaryBlue,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 8),
        const Text("Profile Picture"),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(color: AppColors.Danger, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
