import 'dart:io';

class UpdateAccountRequest {
  final String Name;
  final DateTime DateOfBirth;
  final int CityId;
  final String Address;
  final File ProfilePictureFile;

  UpdateAccountRequest({
    required this.Name,
    required this.DateOfBirth,
    required this.CityId,
    required this.Address,
    required this.ProfilePictureFile,
  });
}
