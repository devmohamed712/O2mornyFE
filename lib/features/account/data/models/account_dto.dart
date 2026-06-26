import 'package:O2morny/shared/enums.dart';

class AccountDto {
  final String Id;
  final String Name;
  final String NationalId;
  final String NationalIdPicture;
  final String DateOfBirth;
  final bool HideBirthDate;
  final int CityId;
  final String Address;
  final String ProfilePicture;
  final AccountStatus Status;
  double? ServiceProviderExperienceYears;
  String? ServiceProviderDescription;

  AccountDto({
    required this.Id,
    required this.Name,
    required this.NationalId,
    required this.NationalIdPicture,
    required this.DateOfBirth,
    required this.HideBirthDate,
    required this.CityId,
    required this.Address,
    required this.ProfilePicture,
    required this.Status,
    this.ServiceProviderExperienceYears,
    this.ServiceProviderDescription,
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    return AccountDto(
      Id: json['Id'],
      Name: json['Name'],
      NationalId: json['NationalId'],
      NationalIdPicture: json['NationalIdPicture'],
      DateOfBirth: json['DateOfBirth'],
      HideBirthDate: json['HideBirthDate'],
      CityId: json['CityId'],
      Address: json['Address'],
      ProfilePicture: json['ProfilePicture'],
      Status: AccountStatus.values[json['Status']],
      ServiceProviderExperienceYears: json['ServiceProviderExperienceYears'],
      ServiceProviderDescription: json['ServiceProviderDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'Name': Name,
      'NationalId': NationalId,
      'NationalIdPicture': NationalIdPicture,
      'DateOfBirth': DateOfBirth,
      'HideBirthDate': HideBirthDate,
      'CityId': CityId,
      'Address': Address,
      'ProfilePicture': ProfilePicture,
      'Status': Status.index,
      'ServiceProviderExperienceYears': ServiceProviderExperienceYears,
      'ServiceProviderDescription': ServiceProviderDescription
    };
  }
}
