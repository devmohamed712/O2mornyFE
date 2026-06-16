import 'dart:convert';
import 'package:O2morny/shared/enums.dart';
import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/core/services/storage_service.dart';
import 'package:O2morny/features/account/data/models/account_dto.dart';

class AuthStorageService {
  final StorageService storageService = getIt<StorageService>();

  Future<void> saveToken(String token) async {
    await storageService.setString(StorageTypes.Token.value, token);
  }

  String? getToken() {
    return storageService.getString(StorageTypes.Token.value);
  }

  Future<void> clearToken() async {
    await storageService.remove(StorageTypes.Token.value);
  }

  Future<void> saveRole(String role) async {
    await storageService.setString(StorageTypes.Role.value, role);
  }

  String? getRole() {
    return storageService.getString(StorageTypes.Role.value);
  }

  Future<void> clearRole() async {
    await storageService.remove(StorageTypes.Role.value);
  }

  Future<void> saveAccount(AccountDto model) async {
    await storageService.setString(
      StorageTypes.Account.value,
      jsonEncode(model.toJson()),
    );
  }

  AccountDto? getAccount() {
    final json = storageService.getString(StorageTypes.Account.value);

    if (json == null) {
      return null;
    }

    return AccountDto.fromJson(jsonDecode(json));
  }

  Future<void> clearAccount() async {
    await storageService.remove(StorageTypes.Account.value);
  }

  Future<void> clearAll() async {
    await storageService.clear();
  }
}
