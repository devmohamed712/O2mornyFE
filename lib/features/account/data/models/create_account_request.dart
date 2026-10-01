import 'dart:io';

class CreateAccountRequest {
  final String Name;
  final DateTime DateOfBirth;
  final int CityId;
  final String Address;
  final bool IsAcceptTerms;
  final bool IsAcceptPrivacy;
  final File ProfilePictureFile;

  CreateAccountRequest({
    required this.Name,
    required this.DateOfBirth,
    required this.CityId,
    required this.Address,
    required this.IsAcceptTerms,
    required this.IsAcceptPrivacy,
    required this.ProfilePictureFile,
  });
}
