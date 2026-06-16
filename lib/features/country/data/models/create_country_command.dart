class CreateCountryCommand {
  final String ArName;
  final String EnName;

  CreateCountryCommand({required this.ArName, required this.EnName});

  Map<String, dynamic> toJson() {
    return {"ArName": ArName, "EnName": EnName};
  }
}
