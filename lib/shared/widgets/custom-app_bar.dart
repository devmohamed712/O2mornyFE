import 'dart:ui';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const CustomAppBar({super.key, required this.title, this.showBack = true});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.55),
            border: Border(
              bottom: BorderSide(color: Colors.black.withOpacity(0.06)),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (showBack)
                    Positioned(
                      left: 4,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        color: AppColors.PrimaryBlue,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.PrimaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
