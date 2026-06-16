class UpdateCountryCommand {
  final int Id;
  final String ArName;
  final String EnName;

  UpdateCountryCommand({
    required this.Id,
    required this.ArName,
    required this.EnName,
  });

  Map<String, dynamic> toJson() {
    return {"Id": Id, "ArName": ArName, "EnName": EnName};
  }
}
