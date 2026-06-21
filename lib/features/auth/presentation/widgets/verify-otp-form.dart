import 'package:O2morny/core/routing/auth_state.dart';
import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/auth/data/services/auth_storage_service.dart';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:O2morny/features/auth/data/models/verify_otp_command.dart';
import 'package:O2morny/features/auth/data/services/auth_service.dart';

class VerifyOtpForm extends StatefulWidget {
  final String phone;
  final String? userImage;
  final VoidCallback onChangePhone;

  const VerifyOtpForm({
    super.key,
    required this.phone,
    required this.userImage,
    required this.onChangePhone,
  });

  @override
  State<VerifyOtpForm> createState() => _VerifyOtpFormState();
}

class _VerifyOtpFormState extends State<VerifyOtpForm> {
  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;
  final AuthStorageService authStorageService = getIt<AuthStorageService>();
  final AuthState authState = getIt<AuthState>();
  final AuthService authService = getIt<AuthService>();

  @override
  void initState() {
    super.initState();

    otpControllers = List.generate(6, (_) => TextEditingController());

    otpFocusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in otpControllers) {
      c.dispose();
    }

    for (var f in otpFocusNodes) {
      f.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/icon-transparent.png", height: 260),

        const SizedBox(height: 50),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 50,

              child: TextField(
                controller: otpControllers[index],

                focusNode: otpFocusNodes[index],

                keyboardType: TextInputType.number,

                textAlign: TextAlign.center,

                cursorColor: AppColors.PrimaryBlue,

                maxLength: 1,

                style: const TextStyle(
                  color: AppColors.PrimaryBlue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),

                decoration: InputDecoration(
                  counterText: "",

                  filled: true,
                  fillColor: AppColors.Light,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.PrimaryBlue),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: AppColors.PrimaryGold,
                      width: 2,
                    ),
                  ),

                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.Danger),
                  ),

                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.Danger, width: 2),
                  ),
                ),

                onChanged: (value) => onOtpChanged(value, index),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 24),

        TextButton(
          onPressed: widget.onChangePhone,

          child: const Text(
            "Change Phone Number",

            style: TextStyle(fontSize: 16, color: AppColors.PrimaryGold),
          ),
        ),
      ],
    );
  }

  Future<void> verifyOtp(String otp) async {
    try {
      final authResponse = await authService.verifyOtp(
        VerifyOtpCommand(PhoneNumber: widget.phone, OTP: otp),
      );
      await authState.setAuth(authResponse);
    } catch (e) {
      showError(e.toString());
    }
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      otpFocusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }

    final otp = otpControllers.map((e) => e.text).join();

    if (otp.length == 6) {
      FocusScope.of(context).unfocus();
      verifyOtp(otp);
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: AppColors.Danger, content: Text(msg)));
  }

  void showSuccess(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text(msg)));
  }
}
