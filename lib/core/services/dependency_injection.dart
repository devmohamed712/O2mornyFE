import 'package:O2morny/core/network/api_constants.dart';
import 'package:O2morny/core/network/dio-Interceptor.dart';
import 'package:O2morny/core/routing/auth_state.dart';
import 'package:O2morny/features/account/data/services/account_service.dart';
import 'package:O2morny/features/city/data/services/city_service.dart';
import 'package:O2morny/features/country/data/services/country_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:O2morny/core/services/signalr_service.dart';
import 'package:O2morny/core/services/storage_service.dart';
import 'package:O2morny/features/auth/data/services/auth_service.dart';
import 'package:O2morny/features/auth/data/services/auth_storage_service.dart';
import 'package:O2morny/features/chat/data/services/chat_service.dart';
import 'package:O2morny/features/chat/presentation/controller/chat_controller.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Services
  getIt.registerLazySingleton<SignalRService>(() => SignalRService());
  getIt.registerLazySingleton<StorageService>(() => StorageService());
  getIt.registerLazySingleton<AuthState>(() => AuthState());
  getIt.registerLazySingleton<AuthStorageService>(() => AuthStorageService());
  getIt.registerLazySingleton<CountryService>(
    () => CountryService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<CityService>(() => CityService(getIt<Dio>()));
  getIt.registerLazySingleton<ChatService>(() => ChatService(getIt<Dio>()));
  getIt.registerLazySingleton<AccountService>(
    () => AccountService(getIt<Dio>()),
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.apiUrl,
      contentType: Headers.jsonContentType,
    ),
  );

  dio.interceptors.add(DioInterceptor());

  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<Dio>()));
  // Controllers
  getIt.registerFactory<ChatController>(() => ChatController());
}
