import 'package:O2morny/core/exceptions/app_exception.dart';
import 'package:O2morny/features/country/data/models/country_dto.dart';
import 'package:O2morny/features/country/data/models/create_country_command.dart';
import 'package:O2morny/features/country/data/models/update_country_command.dart';
import 'package:dio/dio.dart';
import 'package:O2morny/core/network/api_constants.dart';

class CountryService {
  final String apiCountryUrl = "${ApiConstants.apiUrl}country/";

  final Dio dio;

  CountryService(this.dio);

  Future<CountryDto> create(CreateCountryCommand command) async {
    try {
      final response = await dio.post(
        '${apiCountryUrl}create',
        data: command.toJson(),
      );
      return CountryDto.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to create country',
      );
    }
  }

  Future<CountryDto> update(UpdateCountryCommand command) async {
    try {
      final response = await dio.post(
        '${apiCountryUrl}update',
        data: command.toJson(),
      );
      return CountryDto.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to update country',
      );
    }
  }

  Future<void> delete(int id) async {
    try {
      final response = await dio.delete(
        '${apiCountryUrl}delete',
        data: {"id": id},
      );
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to delete country',
      );
    }
  }

  Future<List<CountryDto>> getAll() async {
    try {
      final response = await dio.get('${apiCountryUrl}');
      return (response.data as List)
          .map((e) => CountryDto.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to get countries',
      );
    }
  }

  Future<CountryDto> getById(int id) async {
    try {
      final response = await dio.get('${apiCountryUrl}getById/$id');
      return CountryDto.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to get country',
      );
    }
  }
}
