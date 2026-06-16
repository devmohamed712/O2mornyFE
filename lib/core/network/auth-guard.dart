import 'dart:convert';
import 'package:O2morny/shared/enums.dart';
import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/account/data/models/account_dto.dart';
import 'package:O2morny/features/account/presentation/pages/create_account.dart';
import 'package:O2morny/features/auth/data/services/auth_storage_service.dart';
import 'package:O2morny/features/auth/presentation/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';

class RouteMeta {
  final List<String> allowedRoles;
  RouteMeta({this.allowedRoles = const []});
}

GoRoute BuildRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) builder,
  List<String> allowedRoles = const [],
}) {
  final AuthStorageService authStorageService = getIt<AuthStorageService>();

  return GoRoute(
    path: path,
    builder: builder,
    redirect: (context, state) {
      String? userJson = localStorage.getItem(StorageTypes.Account.value);
      AccountDto? account = userJson != null
          ? AccountDto.fromJson(jsonDecode(userJson))
          : null;
      var token = authStorageService.getToken();
      if (token == null) {
        return LoginPage.route;
      } else {
        if (token != null && account == null && state.path != LoginPage.route) {
          return CreateAccountPage.route;
        }
        var role = authStorageService.getRole();
        if (allowedRoles.isNotEmpty && !allowedRoles.contains(role)) {
          // return UnAuthorizedPage.route;
        }
      }
      return null;
    },
  );
}
