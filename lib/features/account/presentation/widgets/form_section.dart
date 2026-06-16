import 'package:O2morny/features/auth/data/models/role_dto.dart';
import 'package:O2morny/shared/widgets/app_check_box_field.dart';
import 'package:O2morny/shared/widgets/app_date_picker_field.dart';
import 'package:O2morny/features/city/data/models/city_dto.dart';
import 'package:O2morny/features/country/data/models/country_dto.dart';
import 'package:O2morny/shared/widgets/app_text_field.dart';
import 'package:O2morny/shared/widgets/app_drop_down_field.dart';
import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController nationalIdController;
  final TextEditingController addressController;

  DateTime? selectedDate;
  final bool hideBirthDate;

  final CountryDto? selectedCountry;
  final List<CountryDto> countries;
  final CityDto? selectedCity;
  final List<CityDto> cities;
  final RoleDto? selectedRole;
  final List<RoleDto> roles;

  final Function(DateTime) onBirthDateSelect;
  final Function(bool) onHideBirthDateChanged;
  final Function(CountryDto) onCountrySelect;
  final Function(CityDto) onCitySelect;
  final Function(RoleDto) onRoleSelect;

  final Function(String fieldName)? onFieldChanged;

  final Map<String, List<String>> serverErrors;

  FormSection({
    super.key,
    required this.nameController,
    required this.nationalIdController,
    required this.addressController,
    required this.selectedDate,
    required this.hideBirthDate,
    required this.selectedCountry,
    required this.countries,
    required this.selectedCity,
    required this.cities,
    required this.selectedRole,
    required this.roles,
    required this.onBirthDateSelect,
    required this.onHideBirthDateChanged,
    required this.onCountrySelect,
    required this.onCitySelect,
    required this.onRoleSelect,
    required this.onFieldChanged,
    required this.serverErrors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: nameController,
          label: "Full Name",
          onChanged: (_) => onFieldChanged?.call("Name"),
          onValidated: (value) {
            if (value.isEmpty) {
              return "Full name is required.";
            } else if (value.length > 256) {
              return "Full name shouldn't exceed 256 characters.";
            }
            return null;
          },
          serverError: serverErrors["Name"]?.first,
        ),

        const SizedBox(height: 12),

        AppTextField(
          controller: nationalIdController,
          label: "National ID",
          keyboardType: TextInputType.number,
          onChanged: (_) => onFieldChanged?.call("NationalId"),
          onValidated: (value) {
            if (value.isEmpty) {
              return "National id is required.";
            } else if (value.length > 128) {
              return "National id shouldn't exceed 128 characters.";
            }
            return null;
          },
          serverError: serverErrors["NationalId"]?.first,
        ),

        const SizedBox(height: 12),

        AppDatePickerField(
          initialDate: selectedDate,
          firstDate: DateTime(1900),
          lastDate: selectedDate ?? DateTime.now(),
          onChanged: (date) {
            onFieldChanged?.call("DateOfBirth");
            selectedDate = date;
            onBirthDateSelect(date);
          },
          onValidated: (value) {
            if (value != null) {
              return "Date of birth is required.";
            }
            return null;
          },
          serverError: serverErrors["DateOfBirth"]?.first,
        ),

        const SizedBox(height: 12),

        AppCheckBoxField(
          title: "Hide Birth Date",
          value: hideBirthDate,
          onChanged: (v) => onHideBirthDateChanged(v ?? false),
        ),

        const SizedBox(height: 12),

        AppDropDownField<RoleDto>(
          selected: selectedRole,
          lst: roles,
          hint: "Select Role",
          onSelect: onRoleSelect,
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

        AppDropDownField<CountryDto>(
          selected: selectedCountry,
          lst: countries,
          hint: "Select Country",
          onSelect: onCountrySelect,
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
          selected: selectedCity,
          lst: cities,
          hint: "Select City",
          onSelect: onCitySelect,
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
          controller: addressController,
          label: "Address",
          maxLines: 3,
          onChanged: (_) => onFieldChanged?.call("Address"),
          onValidated: (value) {
            if (value.isEmpty) {
              return "Address is required.";
            } else if (value.length > 512) {
              return "Address shouldn't exceed 512 characters.";
            }
            return null;
          },
          serverError: serverErrors["Address"]?.first,
        ),
      ],
    );
  }
}
