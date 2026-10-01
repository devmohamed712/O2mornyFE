class AccountDto {
  final String Id;
  final String Name;
  final String DateOfBirth;
  final int CityId;
  final String Address;
  final String ProfilePicture;

  AccountDto({
    required this.Id,
    required this.Name,
    required this.DateOfBirth,
    required this.CityId,
    required this.Address,
    required this.ProfilePicture
  });

  factory AccountDto.fromJson(Map<String, dynamic> json) {
    return AccountDto(
      Id: json['Id'],
      Name: json['Name'],
      DateOfBirth: json['DateOfBirth'],
      CityId: json['CityId'],
      Address: json['Address'],
      ProfilePicture: json['ProfilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'Name': Name,
      'DateOfBirth': DateOfBirth,
      'CityId': CityId,
      'Address': Address,
      'ProfilePicture': ProfilePicture,
    };
  }
}
