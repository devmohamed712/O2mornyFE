import 'dart:io';
import 'package:flutter/material.dart';

class NationalIdPicture extends StatelessWidget {
  final File? nationalIdImage;
  final VoidCallback onPick;

  const NationalIdPicture({
    super.key,
    required this.nationalIdImage,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        child: nationalIdImage == null
            ? const Center(child: Text("Capture National ID"))
            : Image.file(nationalIdImage!, fit: BoxFit.cover),
      ),
    );
  }
}
