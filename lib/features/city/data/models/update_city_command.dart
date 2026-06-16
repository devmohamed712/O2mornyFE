class UpdateCityCommand {
  final int Id;
  final String ArName;
  final String EnName;
  final int CountryId;

  UpdateCityCommand({
    required this.Id,
    required this.ArName,
    required this.EnName,
    required this.CountryId,
  });

  Map<String, dynamic> toJson() {
    return {
      "Id": Id,
      "ArName": ArName,
      "EnName": EnName,
      "CountryId": CountryId,
    };
  }
}
