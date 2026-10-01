class CountryDto {
  final int? Id;
  final String EnName;
  final String ArName;
  final String? Code;
  final String? FlagPicture;

  CountryDto({
    this.Id,
    required this.EnName,
    required this.ArName,
    this.Code,
    this.FlagPicture,
  });

  factory CountryDto.fromJson(Map<String, dynamic> json) {
    return CountryDto(
      Id: json['Id'],
      EnName: json['EnName'],
      ArName: json['ArName'],
    );
  }
}
