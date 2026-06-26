import 'dart:io';

class UpdateAccountRequest {
  final String Name;
  final DateTime DateOfBirth;
  final bool HideBirthDate;
  final int CityId;
  final String Address;
  final File ProfilePictureFile;
  final String Role;
  double? ServiceProviderExperienceYears;
  String? ServiceProviderDescription;

  UpdateAccountRequest({
    required this.Name,
    required this.DateOfBirth,
    required this.HideBirthDate,
    required this.CityId,
    required this.Address,
    required this.ProfilePictureFile,
    required this.Role,
    this.ServiceProviderExperienceYears,
    this.ServiceProviderDescription,
  });
}
