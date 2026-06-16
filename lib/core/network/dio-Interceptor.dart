import 'package:O2morny/core/routing/auth_state.dart';
import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/auth/data/services/auth_storage_service.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class DioInterceptor extends Interceptor {
  final AuthStorageService authStorageService =
      getIt<AuthStorageService>();

  final AuthState authState =
      getIt<AuthState>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = authStorageService.getToken();

    if (token?.isNotEmpty == true) {
      options.headers['Authorization'] =
          'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await authState.logout();
    }

    handler.next(err);
  }
}