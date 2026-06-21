import 'dart:io';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class NationalIdPicture extends StatelessWidget {
  final File? nationalIdImage;
  final VoidCallback onPick;
  final String? errorText;

  const NationalIdPicture({
    super.key,
    required this.nationalIdImage,
    required this.onPick,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
            ),
            child: nationalIdImage == null
                ? const Center(child: Text("Capture National ID"))
                : Image.file(nationalIdImage!, fit: BoxFit.cover),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                errorText!,
                style: const TextStyle(color: AppColors.Danger, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
