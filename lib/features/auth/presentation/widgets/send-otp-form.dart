import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/auth/data/models/send_otp_command.dart';
import 'package:O2morny/features/auth/data/services/auth_service.dart';
import 'package:O2morny/features/auth/presentation/widgets/country-code-field.dart';
import 'package:O2morny/features/country/data/models/country_dto.dart';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:O2morny/shared/widgets/app_submit_button.dart';
import 'package:O2morny/shared/widgets/app_text_field.dart';
import 'package:O2morny/shared/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

class SendOtpForm extends StatefulWidget {
  final Function({required String phone}) onOtpSent;

  const SendOtpForm({super.key, required this.onOtpSent});

  @override
  State<SendOtpForm> createState() => _SendOtpFormState();
}

class _SendOtpFormState extends State<SendOtpForm> {
  final AuthService authService = getIt<AuthService>();
  List<CountryDto> countries = [
    CountryDto(
      ArName: "مصر",
      EnName: "Egypt",
      Code: "+20",
      FlagPicture: "eg.png",
    ),
    CountryDto(
      ArName: "السعودية",
      EnName: "Saudi Arabia",
      Code: "+966",
      FlagPicture: "sa.png",
    ),
    CountryDto(
      ArName: "الإمارات",
      EnName: "UAE",
      Code: "+971",
      FlagPicture: "ae.png",
    ),
    CountryDto(
      ArName: "الكويت",
      EnName: "Kuwait",
      Code: "+965",
      FlagPicture: "kw.png",
    ),
    CountryDto(
      ArName: "قطر",
      EnName: "Qatar",
      Code: "+974",
      FlagPicture: "qa.png",
    ),
    CountryDto(
      ArName: "البحرين",
      EnName: "Bahrain",
      Code: "+973",
      FlagPicture: "bh.png",
    ),
    CountryDto(
      ArName: "عمان",
      EnName: "Oman",
      Code: "+968",
      FlagPicture: "om.png",
    ),
    CountryDto(
      ArName: "اليمن",
      EnName: "Yemen",
      Code: "+967",
      FlagPicture: "ye.png",
    ),
    CountryDto(
      ArName: "الأردن",
      EnName: "Jordan",
      Code: "+962",
      FlagPicture: "jo.png",
    ),
    CountryDto(
      ArName: "لبنان",
      EnName: "Lebanon",
      Code: "+961",
      FlagPicture: "le.png",
    ),
    CountryDto(
      ArName: "سوريا",
      EnName: "Syria",
      Code: "+963",
      FlagPicture: "sy.png",
    ),
    CountryDto(
      ArName: "العراق",
      EnName: "Iraq",
      Code: "+964",
      FlagPicture: "iq.png",
    ),
    CountryDto(
      ArName: "فلسطين",
      EnName: "Palestine",
      Code: "+970",
      FlagPicture: "ps.png",
    ),
    CountryDto(
      ArName: "ليبيا",
      EnName: "Libya",
      Code: "+218",
      FlagPicture: "ly.png",
    ),
    CountryDto(
      ArName: "تونس",
      EnName: "Tunisia",
      Code: "+216",
      FlagPicture: "tn.png",
    ),
    CountryDto(
      ArName: "الجزائر",
      EnName: "Algeria",
      Code: "+213",
      FlagPicture: "dz.png",
    ),
    CountryDto(
      ArName: "المغرب",
      EnName: "Morocco",
      Code: "+212",
      FlagPicture: "ma.png",
    ),
    CountryDto(
      ArName: "موريتانيا",
      EnName: "Mauritania",
      Code: "+222",
      FlagPicture: "mr.png",
    ),
    CountryDto(
      ArName: "السودان",
      EnName: "Sudan",
      Code: "+249",
      FlagPicture: "sd.png",
    ),
    CountryDto(
      ArName: "الصومال",
      EnName: "Somalia",
      Code: "+252",
      FlagPicture: "so.png",
    ),
    CountryDto(
      ArName: "جيبوتي",
      EnName: "Djibouti",
      Code: "+253",
      FlagPicture: "dj.png",
    ),
    CountryDto(
      ArName: "جزر القمر",
      EnName: "Comoros",
      Code: "+269",
      FlagPicture: "km.png",
    ),
  ];
  late CountryDto selectedCountry;
  final phoneController = TextEditingController();
  bool validationError = false;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();

    selectedCountry = countries[0];
  }

  @override
  void dispose() {
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
              flex: 4,
              child: CountryCodeField(
                countries: countries,
                selectedCode: selectedCountry,
                onSelected: (country) {
                  setState(() => selectedCountry = country!);
                },
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
                onChanged: (value) {
                  setState(() {
                    validationError = false;
                  });
                },
                onValidated: (p0) {},
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        if (validationError) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Country code and Phone number are required",
                style: TextStyle(color: AppColors.Danger, fontSize: 12),
              ),
            ],
          ),
        ],

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

    if (phoneController.text.trim().isEmpty || selectedCountry == null) {
      if (context.mounted) {
        setState(() {
          validationError = true;
        });
      }
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final fullPhone = "${selectedCountry.Code}${phoneController.text}";

      await authService.sendOtp(SendOtpCommand(PhoneNumber: fullPhone));

      widget.onOtpSent(phone: fullPhone);
    } catch (e) {
      if (context.mounted) {
        CustomToast.error(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }
}
