import 'dart:io';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final File? image;
  final VoidCallback onPick;

  const ProfilePicture({super.key, required this.image, required this.onPick});

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
      ],
    );
  }
}
