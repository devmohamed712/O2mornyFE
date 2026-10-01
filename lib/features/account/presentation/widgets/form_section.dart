import 'dart:io';
import 'package:O2morny/features/account/presentation/widgets/profile_picture.dart';
import 'package:O2morny/shared/widgets/app_check_box_field.dart';
import 'package:O2morny/shared/widgets/app_date_picker_field.dart';
import 'package:O2morny/features/city/data/models/city_dto.dart';
import 'package:O2morny/features/country/data/models/country_dto.dart';
import 'package:O2morny/shared/widgets/app_text_field.dart';
import 'package:O2morny/shared/widgets/app_drop_down_field.dart';
import 'package:flutter/material.dart';

class FormSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final File? selectedProfilePicture;
  final List<CountryDto> countries;
  final List<CityDto> cities;
  final CountryDto? selectedCountry;
  final CityDto? selectedCity;

  final Future<void> Function() onProfilePictureSelect;
  final Function(DateTime) onBirthDateSelect;
  final Function(CountryDto) onCountrySelect;
  final Function(CityDto) onCitySelect;
  final Function(String fieldName)? onFieldChanged;
  final Function(bool) onAcceptTermsChanged;
  final Function(bool) onAcceptPrivacyChanged;

  final String? profilePictureError;
  final Map<String, List<String>> serverErrors;

  FormSection({
    super.key,
    required this.selectedProfilePicture,
    required this.nameController,
    required this.addressController,
    required this.countries,
    required this.cities,
    required this.selectedCountry,
    required this.selectedCity,
    required this.onProfilePictureSelect,
    required this.onBirthDateSelect,
    required this.onCountrySelect,
    required this.onCitySelect,
    required this.onFieldChanged,
    required this.onAcceptTermsChanged,
    required this.onAcceptPrivacyChanged,
    required this.serverErrors,
    this.profilePictureError,
  });

  @override
  State<FormSection> createState() => FormSectionState();
}

class FormSectionState extends State<FormSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePicture(
          image: widget.selectedProfilePicture,
          onPick: widget.onProfilePictureSelect,
          errorText: widget.profilePictureError,
        ),

        const SizedBox(height: 24),

        AppTextField(
          controller: widget.nameController,
          label: "Full Name",
          onChanged: (_) => widget.onFieldChanged?.call("Name"),
          onValidated: (value) {
            if (value.isEmpty) {
              return "Full name is required.";
            } else if (value.length >= 256) {
              return "Full name shouldn't exceed 256 characters.";
            }
            return null;
          },
          serverError: widget.serverErrors["Name"]?.first,
        ),

        const SizedBox(height: 12),

        AppDatePickerField(
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          onChanged: (date) {
            widget.onFieldChanged?.call("DateOfBirth");
            widget.onBirthDateSelect(date);
          },
          onValidated: (date) {
            if (date == null) {
              return "Date of birth is required.";
            }

            return null;
          },
          serverError: widget.serverErrors["DateOfBirth"]?.first,
        ),

        const SizedBox(height: 12),

        AppDropDownField<CountryDto>(
          selected: widget.selectedCountry,
          lst: widget.countries,
          hint: "Select Country",
          onSelect: widget.onCountrySelect,
          displayText: (x) => x.EnName,
          value: (x) => x.Id,
          onValidated: (v) {
            if (v == null) {
              return "Country is required";
            }
            return null;
          },
        ),

        const SizedBox(height: 12),

        AppDropDownField<CityDto>(
          selected: widget.selectedCity,
          lst: widget.cities,
          hint: "Select City",
          onSelect: widget.onCitySelect,
          displayText: (x) => x.EnName,
          value: (x) => x.Id,
          onValidated: (v) {
            if (v == null) {
              return "City is required";
            }
            return null;
          },
        ),

        const SizedBox(height: 12),

        AppTextField(
          controller: widget.addressController,
          label: "Address",
          maxLines: 3,
          onChanged: (_) => widget.onFieldChanged?.call("Address"),
          onValidated: (value) {
            if (value.isEmpty) {
              return "Address is required.";
            } else if (value.length >= 512) {
              return "Address shouldn't exceed 512 characters.";
            }
            return null;
          },
          serverError: widget.serverErrors["Address"]?.first,
        ),

        const SizedBox(height: 24),

        AppCheckBoxField(
          title: "Terms & Conditions",
          initialValue: false,
          onChanged: (v) => widget.onAcceptTermsChanged(v ?? false),
          errorText: "You must accept the Terms & Conditions to continue",
        ),

        AppCheckBoxField(
          title: "Privacy Policy",
          initialValue: false,
          onChanged: (v) => widget.onAcceptPrivacyChanged(v ?? false),
          errorText: "You must accept the Privacy Policy to proceed",
        ),
      ],
    );
  }
}
