import 'package:O2morny/features/auth/presentation/widgets/send-otp-form.dart';
import 'package:O2morny/features/auth/presentation/widgets/verify-otp-form.dart';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const route = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool otpMode = false;
  String fullPhone = "";
  String? userImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Light,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),

                child: otpMode
                    ? VerifyOtpForm(
                        key: const ValueKey(2),
                        phone: fullPhone,
                        userImage: userImage,
                        onChangePhone: changePhone,
                      )
                    : SendOtpForm(key: const ValueKey(1), onOtpSent: onOtpSent),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onOtpSent({required String phone, String? image}) {
    setState(() {
      otpMode = true;
      fullPhone = phone;
      userImage = image;
    });
  }

  void changePhone() {
    setState(() {
      otpMode = false;
    });
  }
}
