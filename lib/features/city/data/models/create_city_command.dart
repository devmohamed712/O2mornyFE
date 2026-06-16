class CreateCityCommand {
  final String ArName;
  final String EnName;
  final int CountryId;

  CreateCityCommand({
    required this.ArName,
    required this.EnName,
    required this.CountryId,
  });

  Map<String, dynamic> toJson() {
    return {"ArName": ArName, "EnName": EnName, "CountryId": CountryId};
  }
}
