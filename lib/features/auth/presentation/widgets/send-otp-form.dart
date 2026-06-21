import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/auth/data/models/send_otp_command.dart';
import 'package:O2morny/features/auth/data/services/auth_service.dart';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:O2morny/shared/widgets/app_submit_button.dart';
import 'package:O2morny/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class SendOtpForm extends StatefulWidget {
  final Function({required String phone}) onOtpSent;

  const SendOtpForm({super.key, required this.onOtpSent});

  @override
  State<SendOtpForm> createState() => _SendOtpFormState();
}

class _SendOtpFormState extends State<SendOtpForm> {
  final AuthService authService = getIt<AuthService>();
  final countryCodeController = TextEditingController(text: "+20");

  final phoneController = TextEditingController();

  bool isSubmitting = false;

  @override
  void dispose() {
    countryCodeController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/icon-transparent.png", height: 260),

        const SizedBox(height: 50),

        Row(
          children: [
            Expanded(
              flex: 2,
              child: AppTextField(
                controller: countryCodeController,
                label: "Code",
                keyboardType: TextInputType.number,
                onValidated: (p0) {},
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              flex: 5,
              child: AppTextField(
                controller: phoneController,
                label: "Phone Number",
                keyboardType: TextInputType.phone,
                onValidated: (p0) {},
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        AppSubmitButton(
          isSubmitting: isSubmitting,
          text: "Send OTP",
          onPressed: sendOtp,
        ),
      ],
    );
  }

  Future<void> sendOtp() async {
    FocusScope.of(context).unfocus();

    if (phoneController.text.trim().isEmpty) {
      showError("Enter phone number");
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final fullPhone = "${countryCodeController.text}${phoneController.text}";

      await authService.sendOtp(SendOtpCommand(PhoneNumber: fullPhone));

      widget.onOtpSent(phone: fullPhone);
    } catch (e) {
      showError(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: AppColors.Danger, content: Text(msg)));
  }
}
