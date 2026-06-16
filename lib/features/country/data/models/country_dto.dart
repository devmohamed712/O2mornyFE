class CountryDto{
  final int Id;
  final String EnName;
  final String ArName;

  CountryDto({
    required this.Id,
    required this.EnName,
    required this.ArName,
  });

  factory CountryDto.fromJson(Map<String, dynamic> json) {
    return CountryDto(
      Id: json['Id'],
      EnName: json['EnName'],
      ArName: json['ArName'],
    );
  }
}