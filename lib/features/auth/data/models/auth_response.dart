import 'package:O2morny/features/account/data/models/account_dto.dart';

class AuthResponse {
  final String Token;
  final String? Role;
  final AccountDto? Account;

  AuthResponse({required this.Token, this.Role, this.Account});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      Token: json['Token'],
      Role: json['Role'],
      Account: json['Account'],
    );
  }
}
