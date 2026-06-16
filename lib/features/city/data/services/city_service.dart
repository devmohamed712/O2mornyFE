import 'package:O2morny/core/exceptions/app_exception.dart';
import 'package:O2morny/features/city/data/models/city_dto.dart';
import 'package:O2morny/features/city/data/models/create_city_command.dart';
import 'package:O2morny/features/city/data/models/update_city_command.dart';
import 'package:dio/dio.dart';
import 'package:O2morny/core/network/api_constants.dart';

class CityService {
  final String apiCityUrl = "${ApiConstants.apiUrl}city/";

  final Dio dio;

  CityService(this.dio);

  Future<CityDto> create(CreateCityCommand command) async {
    try {
      final response = await dio.post(
        '${apiCityUrl}create',
        data: command.toJson(),
      );
      return CityDto.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to create city',
      );
    }
  }

  Future<CityDto> update(UpdateCityCommand command) async {
    try {
      final response = await dio.post(
        '${apiCityUrl}update',
        data: command.toJson(),
      );
      return CityDto.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to update city',
      );
    }
  }

  Future<void> delete(int id) async {
    try {
      final response = await dio.delete(
        '${apiCityUrl}delete',
        data: {"id": id},
      );
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to delete city',
      );
    }
  }

  Future<List<CityDto>> getAll(int countryId) async {
    try {
      final response = await dio.get('${apiCityUrl}country/$countryId');
      return (response.data as List)
          .map((e) => CityDto.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to get cities',
      );
    }
  }

  Future<CityDto> getById(int id) async {
    try {
      final response = await dio.get('${apiCityUrl}getById/$id');
      return CityDto.fromJson(response.data);
    } on DioException catch (e) {
      throw AppException(
        e.response?.data?.toString() ?? e.message ?? 'Failed to get city',
      );
    }
  }
}
