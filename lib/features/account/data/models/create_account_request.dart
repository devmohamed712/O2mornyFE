import 'dart:io';

class CreateAccountRequest {
  final String Name;
  final String NationalId;
  final DateTime DateOfBirth;
  final bool HideBirthDate;
  final int CityId;
  final String Address;
  final bool IsAcceptTerms;
  final bool IsAcceptPrivacy;
  final File NationalIdPictureFile;
  final File ProfilePictureFile;
  final String Role;
  double? ServiceProviderExperienceYears;
  String? ServiceProviderDescription;

  CreateAccountRequest({
    required this.Name,
    required this.NationalId,
    required this.DateOfBirth,
    required this.HideBirthDate,
    required this.CityId,
    required this.Address,
    required this.IsAcceptTerms,
    required this.IsAcceptPrivacy,
    required this.NationalIdPictureFile,
    required this.ProfilePictureFile,
    required this.Role,
    this.ServiceProviderExperienceYears,
    this.ServiceProviderDescription,
  });
}
