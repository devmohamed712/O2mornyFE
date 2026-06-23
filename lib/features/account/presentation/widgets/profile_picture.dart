import 'dart:io';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  final File? image;
  final Future<void> Function() onPick;
  String? errorText = null;

  ProfilePicture({
    super.key,
    required this.image,
    required this.onPick,
    this.errorText,
  });

  @override
  State<ProfilePicture> createState() => ProfilePictureState();
}

class ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (mounted) {
              setState(() {
                widget.errorText = null;
              });
            }
            widget.onPick();
          },
          child: CircleAvatar(
            radius: 55,
            backgroundImage: widget.image != null
                ? FileImage(widget.image!)
                : null,
            child: widget.image == null
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
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: AppColors.Danger, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
