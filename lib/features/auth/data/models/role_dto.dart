class RoleDto {
  final String Id;
  final String Name;
  final String EnName;
  final String ArName;

  RoleDto({
    required this.Id,
    required this.Name,
    required this.EnName,
    required this.ArName,
  });

  factory RoleDto.fromJson(Map<String, dynamic> json) {
    return RoleDto(
      Id: json['Id'],
      Name: json['Name'],
      EnName: json['EnName'],
      ArName: json['ArName'],
    );
  }
}
