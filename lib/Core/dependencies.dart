import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/Core/networking/dio_consumer.dart';
import 'package:pro_icon/Core/networking/interceptor.dart';
import 'package:pro_icon/Features/auth/login/cubit/cubit/login_cubit.dart';
import 'package:pro_icon/Features/auth/register/cubit/cubit/register_cubit.dart';
import 'package:pro_icon/Features/auth/role_selection/cubit/cubit/select_role_cubit.dart';
import 'package:pro_icon/data/repos/auth_repo.dart';
import 'package:pro_icon/data/services/auth_service.dart';
import 'package:pro_icon/data/services/reset_password_service.dart';

import '../data/services/country_service.dart';
import 'local_storage/local_storage_provider.dart';
import 'local_storage/secure_storage_consumer.dart';
import 'utils/role_selection_helper.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => AppInterceptor());
  getIt.registerLazySingleton(() => LogInterceptor());
  getIt.registerLazySingleton<BaseApiProvider>(() => DioConsumer(dio: getIt()));
  getIt.registerLazySingleton<BaseLocalService>(
      () => SecureStorageConsumer(secureStorage: getIt()));

  //services
  getIt.registerLazySingleton(() => RoleSelectionHelper());
  getIt.registerLazySingleton(() => AuthService(apiProvider: getIt()));
  getIt.registerLazySingleton(() => ResetPasswordService(apiProvider: getIt()));
  getIt.registerLazySingleton(() => CountryService(apiProvider: getIt()));

  // repos
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
      authService: getIt(),
      resetPasswordService: getIt(),
      localService: getIt()));

  // cubits
  getIt.registerFactory<SelectRoleCubit>(() => SelectRoleCubit(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit());
  getIt.registerFactory<LoginCubit>(() => LoginCubit(authRepo: getIt()));
}
