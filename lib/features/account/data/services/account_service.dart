import 'package:O2morny/core/exceptions/app_exception.dart';
import 'package:O2morny/core/services/dependency_injection.dart';
import 'package:O2morny/features/account/data/models/account_dto.dart';
import 'package:O2morny/features/account/data/models/create_account_request.dart';
import 'package:O2morny/features/account/data/models/update_account_request.dart';
import 'package:O2morny/features/auth/data/services/auth_storage_service.dart';
import 'package:O2morny/shared/enums.dart';
import 'package:dio/dio.dart';
import 'package:O2morny/core/network/api_constants.dart';

class AccountService {
  final String apiAccountUrl = "${ApiConstants.apiUrl}account/";

  final Dio dio;

  final AuthStorageService authStorageService = getIt<AuthStorageService>();

  AccountService(this.dio);

  Future<AccountDto> create(CreateAccountRequest request) async {
    try {
      final formData = FormData.fromMap({
        "Name": request.Name,
        "NationalId": request.NationalId,
        "DateOfBirth": request.DateOfBirth.toIso8601String(),
        "HideBirthDate": request.HideBirthDate,
        "CityId": request.CityId,
        "Address": request.Address,
        "IsAcceptTerms": request.IsAcceptTerms,
        "IsAcceptPrivacy": request.IsAcceptPrivacy,
        "Role": request.Role,

        "NationalIdPictureFile": await MultipartFile.fromFile(
          request.NationalIdPictureFile.path,
        ),

        "ProfilePictureFile": await MultipartFile.fromFile(
          request.ProfilePictureFile.path,
        ),
        "ServiceProviderExperienceYears":
            request.Role == Roles.ServiceProvider.value
            ? request.ServiceProviderExperienceYears
            : null,
        "ServiceProviderDescription":
            request.Role == Roles.ServiceProvider.value
            ? request.ServiceProviderDescription
            : null,
      });

      final response = await dio.post(apiAccountUrl, data: formData);

      return AccountDto.fromJson(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;

      String message = 'Failed to create account';
      Map<String, dynamic>? errors;

      if (data is Map<String, dynamic>) {
        message = data['message'] ?? message;

        if (data['errors'] is Map) {
          errors = Map<String, dynamic>.from(data['errors']);
        }
      }

      throw AppException(message, errors: errors);
    }
  }

  Future<AccountDto> update(UpdateAccountRequest request) async {
    try {
      final formData = FormData.fromMap({
        "Name": request.Name,
        "DateOfBirth": request.DateOfBirth.toIso8601String(),
        "HideBirthDate": request.HideBirthDate,
        "CityId": request.CityId,
        "Address": request.Address,

        if (request.ProfilePictureFile != null)
          "ProfilePictureFile": await MultipartFile.fromFile(
            request.ProfilePictureFile.path,
          ),
      });
      var response = await dio.post('${apiAccountUrl}', data: formData);
      return AccountDto.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to update account',
      );
    }
  }
}
