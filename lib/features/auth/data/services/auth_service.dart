import 'package:O2morny/core/exceptions/app_exception.dart';
import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/auth/data/models/role_dto.dart';
import 'package:O2morny/features/auth/data/services/auth_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:O2morny/core/network/api_constants.dart';
import 'package:O2morny/features/auth/data/models/auth_response.dart';
import 'package:O2morny/features/auth/data/models/send_otp_command.dart';
import 'package:O2morny/features/auth/data/models/verify_otp_command.dart';

class AuthService {
  final String apiAuthUrl = "${ApiConstants.apiUrl}auth/";

  final Dio dio;

  final AuthStorageService authStorageService = getIt<AuthStorageService>();

  AuthService(this.dio);

  Future<void> sendOtp(SendOtpCommand request) async {
    try {
      await dio.post('${apiAuthUrl}send-otp', data: request.toJson());
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to send OTP',
      );
    }
  }

  Future<AuthResponse> verifyOtp(VerifyOtpCommand request) async {
    try {
      final response = await dio.post(
        '${apiAuthUrl}verify-otp',
        data: request.toJson(),
      );

      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException(e.response?.data?.toString() ?? 'Verification failed');
    }
  }

  Future<List<RoleDto>> getRoles() async {
    try {
      final response = await dio.get('${apiAuthUrl}roles');
      return (response.data as List).map((e) => RoleDto.fromJson(e)).toList();
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to get roles',
      );
    }
  }
}
