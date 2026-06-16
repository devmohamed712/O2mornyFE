import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/account/data/models/account_dto.dart';
import 'package:O2morny/features/auth/data/models/auth_response.dart';
import 'package:O2morny/features/auth/data/services/auth_storage_service.dart';
import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier {
  final AuthStorageService authStorageService = getIt<AuthStorageService>();
  String? token;
  AccountDto? account;

  bool get isLoggedIn => token != null;
  bool get needsProfile => token != null && account == null;

  Future<void> load() async {
    token = authStorageService.getToken();
    account = authStorageService.getAccount();
    notifyListeners();
  }

  Future<void> setAuth(AuthResponse response) async {
    token = response.Token;
    account = response.Account;
    if (response.Token != null) {
      authStorageService.saveToken(response.Token);
    }
    if (response.Account != null) {
      authStorageService.saveAccount(response.Account!);
    }
    if (response.Role != null) {
      authStorageService.saveRole(response.Role!);
    }

    notifyListeners();
  }

  Future<void> logout() async {
    token = null;
    account = null;
    authStorageService.clearAll();
    notifyListeners();
  }
}
