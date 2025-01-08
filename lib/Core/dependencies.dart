import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pro_icon/Core/cubits/phone_registration/phone_register_cubit.dart';
import 'package:pro_icon/Core/cubits/region_cubit/region_cubit.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/Core/networking/dio_consumer.dart';
import 'package:pro_icon/Core/networking/interceptor.dart';
import 'package:pro_icon/Features/CategoryDetails/Cubit/category_details_cubit.dart';
import 'package:pro_icon/Features/auth/login/cubit/login_cubit.dart';
import 'package:pro_icon/Features/auth/register/cubits/set_password_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/forget_password/forget_password_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/otp/otp_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/set_new_password/set_new_password_cubit.dart';
import 'package:pro_icon/Features/auth/role_selection/cubit/cubit/select_role_cubit.dart';
import 'package:pro_icon/Features/client_details/cubit/cubit/client_details_cubit.dart';
import 'package:pro_icon/Features/client_details/medical_report/cubits/cubit/medical_info_cubit.dart';
import 'package:pro_icon/Features/client_details/strategy/cubits/cubit/strategy_cubit.dart';
import 'package:pro_icon/Features/clients/add_client/cubits/cubit/client_registration_cubit.dart';
import 'package:pro_icon/Features/home/cubit/home_cubit.dart';
import 'package:pro_icon/Features/main/cubit/cubit/main_cubit.dart';
import 'package:pro_icon/Features/manage_trainer/cubits/cubit/manage_trainer_cubit.dart';
import 'package:pro_icon/Features/manage_trainer/cubits/cubit/trainer_password_cubit.dart';
import 'package:pro_icon/Features/users/cubits/user_managment_cubit.dart';
import 'package:pro_icon/data/repos/auth_repo.dart';
import 'package:pro_icon/data/services/auth_service.dart';
import 'package:pro_icon/data/services/auth_token_service.dart';
import 'package:pro_icon/data/services/client_strategy_service.dart';
import 'package:pro_icon/data/services/clients_service.dart';
import 'package:pro_icon/data/services/health_condition_service.dart';
import 'package:pro_icon/data/services/reset_password_service.dart';
import 'package:pro_icon/data/services/trainer_service.dart';
import 'package:pro_icon/data/services/user_service.dart';

import '../data/services/categories_services.dart';
import '../data/services/country_service.dart';
import 'cubits/user_state/user_state_cubit.dart';
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
  getIt.registerLazySingleton(
      () => CategoriesServices(baseApiProvider: getIt()));
  getIt.registerLazySingleton(() => TrainerService(apiProvider: getIt()));
  getIt.registerLazySingleton(() => ClientsService(apiProvider: getIt()));
  getIt.registerLazySingleton(
      () => HealthConditionService(apiProvider: getIt()));

  getIt.registerLazySingleton(
      () => ClientStrategyService(baseApiProvider: getIt()));
  // repos
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
      authService: getIt(),
      resetPasswordService: getIt(),
      authTokenService: getIt(),
      userService: getIt()));

  // cubits
  getIt.registerFactory<SelectRoleCubit>(() => SelectRoleCubit(getIt()));
  getIt.registerFactory<PhoneRegistrationCubit>(() => PhoneRegistrationCubit());
  getIt.registerFactory<LoginCubit>(() => LoginCubit(authRepo: getIt()));
  getIt
      .registerFactory<RegionCubit>(() => RegionCubit(countryService: getIt()));
  getIt.registerFactory<SetPasswordCubit>(
      () => SetPasswordCubit(authRepo: getIt()));
  getIt.registerFactory<ForgetPasswordCubit>(
      () => ForgetPasswordCubit(authRepo: getIt()));
  getIt.registerFactory<OtpCubit>(() => OtpCubit(authRepo: getIt()));
  getIt.registerFactory<SetNewPasswordCubit>(
      () => SetNewPasswordCubit(authRepo: getIt()));

  getIt.registerFactory<UserManagmentCubit>(() =>
      UserManagmentCubit(trainerService: getIt(), clientsService: getIt()));
  getIt.registerFactory<ManageTrainerCubit>(() => ManageTrainerCubit(
        trainerService: getIt(),
      ));
  getIt.registerFactory<TrainerPasswordCubit>(() => TrainerPasswordCubit(
        trainerService: getIt(),
      ));
  getIt.registerFactory<ClientRegistrationCubit>(() => ClientRegistrationCubit(
        clientsService: getIt(),
      ));
  getIt.registerFactory<ClientDetailsCubit>(() => ClientDetailsCubit(
        clientsService: getIt(),
      ));

  getIt.registerFactory<MedicalInfoCubit>(() => MedicalInfoCubit(
        healthConditionService: getIt(),
      ));

  getIt.registerFactory<StrategyCubit>(() => StrategyCubit(
        clientStrategyService: getIt(),
      ));

  getIt.registerFactory<HomeCubit>(() => HomeCubit(
        categoriesServices: getIt(),
      ));

  getIt.registerFactory<CategoryDetailsCubit>(() => CategoryDetailsCubit());

  getIt.registerLazySingleton<MainCubit>(() => MainCubit());
  getIt.registerLazySingleton<UserStateCubit>(
    () => UserStateCubit(
      authRepo: getIt(),
      authTokenService: getIt(),
      userService: getIt(),
    ),
  );
}
