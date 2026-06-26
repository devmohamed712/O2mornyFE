import 'dart:io';
import 'package:O2morny/features/account/presentation/widgets/national_id_picture.dart';
import 'package:O2morny/features/account/presentation/widgets/profile_picture.dart';
import 'package:O2morny/features/auth/data/models/role_dto.dart';
import 'package:O2morny/shared/enums.dart';
import 'package:O2morny/shared/widgets/app_check_box_field.dart';
import 'package:O2morny/shared/widgets/app_date_picker_field.dart';
import 'package:O2morny/features/city/data/models/city_dto.dart';
import 'package:O2morny/features/country/data/models/country_dto.dart';
import 'package:O2morny/shared/widgets/app_slider_bar_field.dart';
import 'package:O2morny/shared/widgets/app_text_field.dart';
import 'package:O2morny/shared/widgets/app_drop_down_field.dart';
import 'package:flutter/material.dart';

class FormSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController nationalIdController;
  final TextEditingController addressController;
  final File? selectedProfilePicture;
  final List<CountryDto> countries;
  final List<CityDto> cities;
  final RoleDto? selectedRole;
  final TextEditingController serviceProviderDescriptionController;
  final List<RoleDto> roles;
  final File? selectedNationalIdImage;

  final Future<void> Function() onProfilePictureSelect;
  final Function(DateTime) onBirthDateSelect;
  final Function(bool) onHideBirthDateChanged;
  final Function(CountryDto) onCountrySelect;
  final Function(CityDto) onCitySelect;
  final Function(RoleDto) onRoleSelect;
  Function(double)? onServiceProviderYearsOfExpSelect;
  final Future<void> Function() onNationalIdImageSelect;
  final Function(String fieldName)? onFieldChanged;
  final Function(bool) onAcceptTermsChanged;
  final Function(bool) onAcceptPrivacyChanged;

  final String? profilePictureError;
  final String? nationalIdImageError;
  final Map<String, List<String>> serverErrors;

  FormSection({
    super.key,
    required this.selectedProfilePicture,
    required this.nameController,
    required this.nationalIdController,
    required this.addressController,
    required this.countries,
    required this.cities,
    required this.selectedRole,
    required this.serviceProviderDescriptionController,
    required this.selectedNationalIdImage,
    required this.roles,
    required this.onProfilePictureSelect,
    required this.onBirthDateSelect,
    required this.onHideBirthDateChanged,
    required this.onCountrySelect,
    required this.onCitySelect,
    required this.onRoleSelect,
    this.onServiceProviderYearsOfExpSelect,
    required this.onNationalIdImageSelect,
    required this.onFieldChanged,
    required this.onAcceptTermsChanged,
    required this.onAcceptPrivacyChanged,
    required this.serverErrors,
    this.profilePictureError,
    this.nationalIdImageError,
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

        AppTextField(
          controller: widget.nationalIdController,
          label: "National ID",
          keyboardType: TextInputType.number,
          onChanged: (_) => widget.onFieldChanged?.call("NationalId"),
          onValidated: (value) {
            if (value.isEmpty) {
              return "National id is required.";
            } else if (value.length >= 128) {
              return "National id shouldn't exceed 128 characters.";
            }
            return null;
          },
          serverError: widget.serverErrors["NationalId"]?.first,
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

        AppCheckBoxField(
          title: "Hide Birth Date",
          initialValue: false,
          onChanged: (v) => widget.onHideBirthDateChanged(v ?? false),
        ),

        const SizedBox(height: 12),

        AppDropDownField<RoleDto>(
          selected: widget.selectedRole,
          lst: widget.roles,
          hint: "Select Role",
          onSelect: widget.onRoleSelect,
          displayText: (x) => x.EnName,
          value: (x) => x.Id,
          onValidated: (v) {
            if (v == null) {
              return "Role is required";
            }
            return null;
          },
        ),

        const SizedBox(height: 12),

        if (widget.selectedRole != null &&
            widget.selectedRole!.Name == Roles.ServiceProvider.value) ...[
          const SizedBox(height: 12),

          AppSliderBarField(
            title: 'Years of Experience',
            initialValue: 0.0,
            onChanged: widget.onServiceProviderYearsOfExpSelect!,
            validator: (value) {
              if (widget.selectedRole != null && widget.selectedRole!.Name != Roles.ServiceProvider.value) {
                return null;
              }
              if (value == null || value < 0) {
                return 'Experience is required';
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          AppTextField(
            controller: widget.serviceProviderDescriptionController,
            label: "Description",
            maxLines: 3,
            onChanged: (_) =>
                widget.onFieldChanged?.call("ServiceProviderDescription"),
            onValidated: (value) {
              if (widget.selectedRole != null && widget.selectedRole!.Name != Roles.ServiceProvider.value) {
                return null;
              }
              if (value.isEmpty) {
                return "Description is required.";
              } else if (value.length >= 4000) {
                return "Description shouldn't exceed 4000 characters.";
              }
              return null;
            },
            serverError:
                widget.serverErrors["ServiceProviderDescription"]?.first,
          ),

          const SizedBox(height: 24),
        ],

        AppDropDownField<CountryDto>(
          selected: null,
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
          selected: null,
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

        NationalIdPicture(
          nationalIdImage: widget.selectedNationalIdImage,
          onPick: widget.onNationalIdImageSelect,
          errorText: widget.nationalIdImageError,
        ),

        const SizedBox(height: 20),

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
