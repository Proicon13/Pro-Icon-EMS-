import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pro_icon/Core/cubits/cubit/user_state_cubit.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/Core/networking/dio_consumer.dart';
import 'package:pro_icon/Core/networking/interceptor.dart';
import 'package:pro_icon/Features/auth/login/cubit/login_cubit.dart';
import 'package:pro_icon/Features/auth/register/cubits/address_registration_cubit.dart';
import 'package:pro_icon/Features/auth/register/cubits/register_cubit.dart';
import 'package:pro_icon/Features/auth/register/cubits/set_password_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/forget_password/forget_password_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/otp/otp_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/set_new_password/set_new_password_cubit.dart';
import 'package:pro_icon/Features/auth/role_selection/cubit/cubit/select_role_cubit.dart';
import 'package:pro_icon/Features/users/cubits/user_managment_cubit.dart';
import 'package:pro_icon/data/repos/auth_repo.dart';
import 'package:pro_icon/data/services/auth_service.dart';
import 'package:pro_icon/data/services/auth_token_service.dart';
import 'package:pro_icon/data/services/reset_password_service.dart';
import 'package:pro_icon/data/services/trainer_service.dart';
import 'package:pro_icon/data/services/user_service.dart';

import '../data/services/country_service.dart';
import 'local_storage/local_storage_provider.dart';
import 'local_storage/secure_storage_consumer.dart';
import 'utils/role_selection_helper.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton<BaseLocalService>(
      () => SecureStorageConsumer(secureStorage: getIt()));
  getIt.registerLazySingleton<AuthTokenService>(
      () => AuthTokenService(localService: getIt()));
  getIt.registerLazySingleton(() => AppInterceptor(authTokenService: getIt()));
  getIt.registerLazySingleton(() => LogInterceptor());
  getIt.registerLazySingleton<BaseApiProvider>(() => DioConsumer(dio: getIt()));

  //services
  getIt.registerLazySingleton(() => RoleSelectionHelper());
  getIt.registerLazySingleton(
      () => AuthService(apiProvider: getIt(), tokenService: getIt()));
  getIt.registerLazySingleton(() => ResetPasswordService(apiProvider: getIt()));
  getIt.registerLazySingleton(() => CountryService(apiProvider: getIt()));
  getIt.registerLazySingleton(() => UserService(
        apiProvider: getIt(),
      ));
  getIt.registerLazySingleton(() => TrainerService(apiProvider: getIt()));

  // repos
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
      authService: getIt(),
      resetPasswordService: getIt(),
      authTokenService: getIt(),
      userService: getIt()));

  // cubits
  getIt.registerFactory<SelectRoleCubit>(() => SelectRoleCubit(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit());
  getIt.registerFactory<LoginCubit>(() => LoginCubit(authRepo: getIt()));
  getIt.registerFactory<AddressRegistrationCubit>(
      () => AddressRegistrationCubit(countryService: getIt()));
  getIt.registerFactory<SetPasswordCubit>(
      () => SetPasswordCubit(authRepo: getIt()));
  getIt.registerFactory<ForgetPasswordCubit>(
      () => ForgetPasswordCubit(authRepo: getIt()));
  getIt.registerFactory<OtpCubit>(() => OtpCubit(authRepo: getIt()));
  getIt.registerFactory<SetNewPasswordCubit>(
      () => SetNewPasswordCubit(authRepo: getIt()));
  getIt.registerLazySingleton<UserStateCubit>(() => UserStateCubit(
      userService: getIt(), authRepo: getIt(), authTokenService: getIt()));
  getIt.registerFactory<UserManagmentCubit>(
      () => UserManagmentCubit(trainerService: getIt()));
}
