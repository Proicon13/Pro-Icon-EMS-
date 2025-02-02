import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pro_icon/Core/cubits/client_managment/client_managment_cubit.dart';
import 'package:pro_icon/Core/cubits/phone_registration/phone_register_cubit.dart';
import 'package:pro_icon/Core/cubits/region_cubit/region_cubit.dart';
import 'package:pro_icon/Core/local_storage/hive_consumer.dart';
import 'package:pro_icon/Core/networking/base_api_provider.dart';
import 'package:pro_icon/Core/networking/dio_consumer.dart';
import 'package:pro_icon/Core/networking/interceptor.dart';
import 'package:pro_icon/Features/CategoryDetails/Cubit/category_details_cubit.dart';
import 'package:pro_icon/Features/Mads/Cubit/cubit/session_details_cubit.dart';
import 'package:pro_icon/Features/Mads/Cubit/mads_cubit.dart';
import 'package:pro_icon/Features/Profile/Cubit/profile_cubit.dart';
import 'package:pro_icon/Features/auth/login/cubit/login_cubit.dart';
import 'package:pro_icon/Features/auth/register/cubits/set_password_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/forget_password/forget_password_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/otp/otp_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/set_new_password/set_new_password_cubit.dart';
import 'package:pro_icon/Features/auth/role_selection/cubit/cubit/select_role_cubit.dart';
import 'package:pro_icon/Features/automatic_sessions/cubits/auto_sessions_cubit.dart';
import 'package:pro_icon/Features/automatic_sessions/cubits/custom_auto_session_cubit.dart';
import 'package:pro_icon/Features/automatic_sessions/cubits/main_auto_session_cubit.dart';
import 'package:pro_icon/Features/automatic_sessions/manage_session/cubits/cubit/manage_custom_session_cubit.dart';
import 'package:pro_icon/Features/client_details/cubit/cubit/client_details_cubit.dart';
import 'package:pro_icon/Features/client_details/medical_report/cubits/cubit/medical_info_cubit.dart';
import 'package:pro_icon/Features/client_details/strategy/cubits/cubit/strategy_cubit.dart';
import 'package:pro_icon/Features/clients/add_client/cubits/cubit/client_registration_cubit.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/program_muscles_cubit.dart';
import 'package:pro_icon/Features/home/cubit/home_cubit.dart';
import 'package:pro_icon/Features/main/cubit/cubit/main_cubit.dart';
import 'package:pro_icon/Features/manage_trainer/cubits/cubit/manage_trainer_cubit.dart';
import 'package:pro_icon/Features/manage_trainer/cubits/cubit/trainer_password_cubit.dart';
import 'package:pro_icon/Features/programming_requst/cubit/programmer_request_cubit.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:pro_icon/Features/session_managment/session_setup/cubits/cubit/session_setup_cubit.dart';
import 'package:pro_icon/Features/users/cubits/user_managment_cubit.dart';
import 'package:pro_icon/data/repos/auth_repo.dart';
import 'package:pro_icon/data/repos/mads_repo.dart';
import 'package:pro_icon/data/repos/session_control_panel_repo.dart';
import 'package:pro_icon/data/services/auth_service.dart';
import 'package:pro_icon/data/services/auth_token_service.dart';
import 'package:pro_icon/data/services/auto_session_service.dart';
import 'package:pro_icon/data/services/bluetooth_manager.dart';
import 'package:pro_icon/data/services/client_strategy_service.dart';
import 'package:pro_icon/data/services/clients_service.dart';
import 'package:pro_icon/data/services/custom_program_service.dart';
import 'package:pro_icon/data/services/health_condition_service.dart';
import 'package:pro_icon/data/services/mad_sessions_service.dart';
import 'package:pro_icon/data/services/mads_service.dart';
import 'package:pro_icon/data/services/muscles_service.dart';
import 'package:pro_icon/data/services/profile_service.dart';
import 'package:pro_icon/data/services/reset_password_service.dart';
import 'package:pro_icon/data/services/trainer_service.dart';
import 'package:pro_icon/data/services/user_service.dart';

import '../Features/custom_programs/my_programs/cubits/cubit/my_programs_cubit.dart';
import '../data/services/categories_services.dart';
import '../data/services/country_service.dart';
import '../data/services/programmer_request.dart';
import '../data/services/session_managment_service.dart';
import 'cubits/user_state/user_state_cubit.dart';
import 'local_storage/local_storage_provider.dart';
import 'local_storage/secure_storage_consumer.dart';
import 'utils/role_selection_helper.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton<BaseLocalService>(
      instanceName: "secureStorage",
      () => SecureStorageConsumer(secureStorage: getIt()));
  getIt.registerLazySingleton<ExtendedLocalService>(
      instanceName: "hiveStorage", () => HiveConsumer());
  getIt.registerLazySingleton<AuthTokenService>(() => AuthTokenService(
      localService: getIt<BaseLocalService>(instanceName: "secureStorage")));
  getIt.registerLazySingleton(() => AppInterceptor(authTokenService: getIt()));
  getIt.registerLazySingleton(() => LogInterceptor());
  getIt.registerLazySingleton<BaseApiProvider>(() => DioConsumer(dio: getIt()));
  getIt.registerLazySingleton<BluetoothManager>(() => BluetoothManager());

  //services
  getIt.registerLazySingleton(() => RoleSelectionHelper());
  getIt.registerLazySingleton(
      () => AuthService(apiProvider: getIt(), tokenService: getIt()));
  getIt.registerLazySingleton(() => ResetPasswordService(apiProvider: getIt()));
  getIt.registerLazySingleton(
      () => ProgrammerRequestService(baseApiProvider: getIt()));
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

  getIt.registerLazySingleton(
      () => CustomProgramService(baseApiProvider: getIt()));
  getIt.registerLazySingleton(
      () => SessionManagmentService(baseApiProvider: getIt()));

  getIt.registerLazySingleton(() => ProfileService(apiProvider: getIt()));
  getIt.registerLazySingleton(() => MusclesService(baseApiProvider: getIt()));
  getIt.registerLazySingleton(() => MadLocalService(
          localStorage: getIt<ExtendedLocalService>(
        instanceName: "hiveStorage",
      )));
  getIt.registerLazySingleton(() => MadSessionsService(apiProvider: getIt()));
  getIt.registerLazySingleton(() => AutoSessionService(apiProvider: getIt()));

  // repos
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
      authService: getIt(),
      resetPasswordService: getIt(),
      authTokenService: getIt(),
      userService: getIt()));

  getIt.registerLazySingleton<MadRepository>(() => MadRepository(
        madLocalService: getIt(),
      ));

  getIt.registerLazySingleton<SessionManagementRepository>(
      () => SessionManagementRepositoryImpl(
            madRepository: getIt(),
            musclesService: getIt(),
            bluetoothManager: getIt(),
            sessionManagmentService: getIt(),
          ));

  // cubits
  getIt.registerFactory<SelectRoleCubit>(() => SelectRoleCubit(getIt()));
  getIt.registerFactory<ProgrammerRequestCubit>(
      () => ProgrammerRequestCubit(programmerRequestService: getIt()));
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

  getIt.registerFactory<SessionCubit>(() =>
      SessionCubit(categoriesServices: getIt(), autoSessionService: getIt()));

  getIt.registerFactory<CategoryDetailsCubit>(() => CategoryDetailsCubit());

  getIt.registerFactory<MainCubit>(() => MainCubit());
  getIt.registerLazySingleton<UserStateCubit>(
    () => UserStateCubit(
      authRepo: getIt(),
      authTokenService: getIt(),
      userService: getIt(),
    ),
  );

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      profileService: getIt(),
    ),
  );

  getIt.registerFactory<ManageCustomProgramCubit>(
    () => ManageCustomProgramCubit(
      customProgramService: getIt(),
    ),
  );

  getIt.registerFactory<ProgramMusclesCubit>(
    () => ProgramMusclesCubit(
        customProgramService: getIt(), musclesService: getIt()),
  );

  getIt.registerFactory<MyProgramsCubit>(
    () => MyProgramsCubit(
      customProgramService: getIt(),
    ),
  );

  getIt.registerFactory<MadsCubit>(
    () => MadsCubit(
      madRepository: getIt(),
    ),
  );

  getIt.registerFactory<SessionDetailsCubit>(
    () => SessionDetailsCubit(
      service: getIt(),
    ),
  );
  getIt.registerFactory<AutoSessionsCubit>(
    () => AutoSessionsCubit(),
  );
  getIt.registerFactory<MainAutoSessionCubit>(
    () => MainAutoSessionCubit(
      autoSessionService: getIt(),
    ),
  );
  getIt.registerFactory<CustomAutoSessionCubit>(
    () => CustomAutoSessionCubit(
      autoSessionService: getIt(),
    ),
  );
  getIt.registerFactory<ManageCustomSessionCubit>(
    () => ManageCustomSessionCubit(
      autoSessionService: getIt(),
      categoriesService: getIt(),
    ),
  );

  getIt.registerFactory<ControlPanelCubit>(
    () => ControlPanelCubit(
      sessionManagementRepository: getIt(),
    ),
  );

  getIt.registerFactory<ClientManagementCubit>(
    () => ClientManagementCubit(
      clientsService: getIt(),
    ),
  );
}
