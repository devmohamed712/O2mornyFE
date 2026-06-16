class CityDto{
  final int Id;
  final String EnName;
  final String ArName;
  final int CountryId;

  CityDto({
    required this.Id,
    required this.EnName,
    required this.ArName,
    required this.CountryId
  });

  factory CityDto.fromJson(Map<String, dynamic> json) {
    return CityDto(
      Id: json['Id'],
      EnName: json['EnName'],
      ArName: json['ArName'],
      CountryId: json['CountryId']
    );
  }
}