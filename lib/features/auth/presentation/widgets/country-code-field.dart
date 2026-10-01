import 'package:O2morny/features/country/data/models/country_dto.dart';
import 'package:O2morny/shared/models/app_colors.dart';
import 'package:flutter/material.dart';

class CountryCodeField extends StatefulWidget {
  final List<CountryDto> countries;
  final CountryDto selectedCode;
  final ValueChanged<CountryDto?> onSelected;
  final Function(CountryDto) onValidated;

  CountryCodeField({
    super.key,
    required this.countries,
    required this.selectedCode,
    required this.onSelected,
    required this.onValidated,
  });

  @override
  State<CountryCodeField> createState() => CountryCodeFieldState();
}

class CountryCodeFieldState extends State<CountryCodeField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CountryDto?>(
      value: widget.selectedCode,
      isExpanded: true,
      menuMaxHeight: 250,
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 8,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.PrimaryBlue,
      ),
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),

      decoration: InputDecoration(
        labelText: "Code",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        labelStyle: TextStyle(color: AppColors.PrimaryBlue),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.PrimaryBlue),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.PrimaryGold, width: 2),
        ),
      ),
      items: widget.countries.map((country) {
        return DropdownMenuItem<CountryDto>(
          value: country,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.asset(
                  'assets/images/flags/${country.FlagPicture}',
                  width: 28,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${country.Code})',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (country) {
        if (country == null) return;
        setState(() {});
        widget.onSelected(country);
        widget.onValidated(country);
      },
    );
  }
}
