// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/Core/entities/category_entity.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Features/Mads/session_details/screen/session_activity.dart';
import 'package:pro_icon/Features/languges_screen/cubit/languges_cubit.dart';
import 'package:pro_icon/Features/languges_screen/screen/languges_screen.dart';
import 'package:pro_icon/Features/manage_trainer/screens/trainer_password_regestraion_screen.dart';
import 'package:pro_icon/Features/session_managment/session_setup/cubits/cubit/session_setup_state.dart';

import '../../Features/CategoryDetails/Screens/Category_details.dart';
import '../../Features/Mads/Screens/Mads_screen.dart';
import '../../Features/Profile/Screens/profile_screen.dart';
import '../../Features/auth/login/screens/login_screen.dart';
import '../../Features/auth/register/screens/admin_address_screen.dart';
import '../../Features/auth/register/screens/register_screen.dart';
import '../../Features/auth/register/screens/set_password_screen.dart';
import '../../Features/auth/reset_password/screens/forget_password_screen.dart';
import '../../Features/auth/reset_password/screens/otp_screen.dart';
import '../../Features/auth/reset_password/screens/set_new_password_screen.dart';
import '../../Features/auth/role_selection/screens/role_selection_screen.dart';
import '../../Features/automatic_sessions/manage_session/screens/manage_auto_session_screen.dart';
import '../../Features/automatic_sessions/screens/auto_session_details_screen.dart';
import '../../Features/client_details/client_details_screen.dart';
import '../../Features/clients/add_client/screens/add_client_screen.dart';
import '../../Features/clients/add_client/screens/client_additional_data_screen.dart';
import '../../Features/custom_programs/manage_program/screens/manage_custom_program_screen.dart';
import '../../Features/custom_programs/my_programs/my_programs_screen.dart';
import '../../Features/main/cubit/cubit/main_cubit.dart';
import '../../Features/main/main_screen.dart';
import '../../Features/manage_trainer/screens/manage_trainer_screen.dart';
import '../../Features/programming_requst/screen/programming_request_screen.dart';
import '../../Features/session_managment/control_panel/screens/control_panel_screen.dart';
import '../../Features/session_managment/session_setup/screens/session_setup_screen.dart';
import '../../Features/users/screens/users_screen.dart';
import '../../splash_screen.dart';
import '../entities/program_entity.dart';

Route<dynamic>? onGenerteRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(
        settings: const RouteSettings(name: "/"),
        builder: (_) => const SplashScreen(),
      );

    case RoleSelectionScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: RoleSelectionScreen.routeName),
        builder: (_) => const RoleSelectionScreen(),
      );

    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: LoginScreen.routeName),
        builder: (_) => const LoginScreen(),
      );

    case SetPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: SetPasswordScreen.routeName),
        builder: (_) => const SetPasswordScreen(),
      );

    case ForgetPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ForgetPasswordScreen.routeName),
        builder: (_) => const ForgetPasswordScreen(),
      );

    case OtpScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: OtpScreen.routeName),
        builder: (_) => const OtpScreen(),
      );

    case SetNewPasswordScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: SetNewPasswordScreen.routeName),
        builder: (_) => const SetNewPasswordScreen(),
      );

    case RegisterScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: RegisterScreen.routeName),
        builder: (_) => const RegisterScreen(),
      );

    case AdminAddressScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AdminAddressScreen.routeName),
        builder: (_) => const AdminAddressScreen(),
      );

    case UsersView.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: UsersView.routeName),
        builder: (_) => const UsersView(),
      );
    case ManageTrainerScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ManageTrainerScreen.routeName),
        builder: (_) {
          // Retrieve trainer from arguments
          final trainer = settings.arguments as UserEntity?;
          return ManageTrainerScreen(trainer: trainer);
        },
      );
    case TrainerPasswordRegestraionScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(
            name: TrainerPasswordRegestraionScreen.routeName),
        builder: (_) {
          return const TrainerPasswordRegestraionScreen();
        },
      );
    case AddClientScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AddClientScreen.routeName),
        builder: (_) {
          final toRoute = settings.arguments as String;
          return AddClientScreen(
            toRoute: toRoute,
          );
        },
      );
    case ClientAdditionalDataScreen.routeName:
      return MaterialPageRoute(
        settings:
            const RouteSettings(name: ClientAdditionalDataScreen.routeName),
        builder: (_) {
          final toRoute = settings.arguments as String;
          return ClientAdditionalDataScreen(
            toRoute: toRoute,
          );
        },
      );
    case ClientDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ClientDetailsScreen.routeName),
        builder: (_) {
          final clientId = settings.arguments as int;
          return ClientDetailsScreen(
            clientId: clientId,
          );
        },
      );
    case MainScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: MainScreen.routeName),
        builder: (_) {
          final selectedSection = settings.arguments as MainSections?;
          return MainScreen(
            selectedSection: selectedSection,
          );
        },
      );

    case CategoryDetails.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: CategoryDetails.routeName),
        builder: (_) {
          final arguments = settings.arguments as List<dynamic>;
          final categories = arguments[0] as List<CategoryEntity>;
          final index = arguments[1] as int;

          return CategoryDetails(categories: categories, currentIndex: index);
        },
      );

    case ProfileScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ProfileScreen.routeName),
        builder: (_) {
          return const ProfileScreen();
        },
      );

    case MyProgramsScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: MyProgramsScreen.routeName),
        builder: (_) {
          return const MyProgramsScreen();
        },
      );

    case ManageCustomProgramScreen.routeName:
      return MaterialPageRoute(
        settings:
            const RouteSettings(name: ManageCustomProgramScreen.routeName),
        builder: (_) {
          final program = settings.arguments as CustomProgramEntity?;
          if (program == null) return const ManageCustomProgramScreen();
          return ManageCustomProgramScreen(
            program: program,
          );
        },
      );

    case ProgrammingRequestScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ProgrammingRequestScreen.routeName),
        builder: (_) {
          return const ProgrammingRequestScreen();
        },
      );

    case MadsScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: MadsScreen.routeName),
        builder: (_) {
          return const MadsScreen();
        },
      );

    case SessionActivityScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: SessionActivityScreen.routeName),
        builder: (_) {
          final madId = settings.arguments as int;
          return SessionActivityScreen(
            madId: madId,
          );
        },
      );

    case LangugesScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: LangugesScreen.routeName),
        builder: (_) {
          return BlocProvider(
              create: (context) => LanguageCubit(),
              child: const LangugesScreen());
        },
      );

    case AutoSessionDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: AutoSessionDetailsScreen.routeName),
        builder: (_) {
          final autoSession = settings.arguments as AutomaticSessionEntity;
          return AutoSessionDetailsScreen(session: autoSession);
        },
      );

    case ManageAutoSessionScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ManageAutoSessionScreen.routeName),
        builder: (_) {
          final autoSession = settings.arguments as AutomaticSessionEntity?;
          if (autoSession == null) return const ManageAutoSessionScreen();
          return ManageAutoSessionScreen(session: autoSession);
        },
      );

    case SessionSetupScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: SessionSetupScreen.routeName),
        builder: (_) {
          return const SessionSetupScreen();
        },
      );

    case ControlPanelScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ControlPanelScreen.routeName),
        builder: (_) {
          final arguments = settings.arguments as List<dynamic>;
          final SessionControlMode mode = arguments[0] as SessionControlMode;
          final ProgramEntity? program = arguments[1] as ProgramEntity?;
          final AutomaticSessionEntity? automaticSession =
              arguments[2] as AutomaticSessionEntity?;
          final List<ProgramEntity>? allPrograms =
              arguments[3] as List<ProgramEntity>?;
          return ControlPanelScreen(
            mode: mode,
            program: program,
            session: automaticSession,
            programs: allPrograms,
          );
        },
      );

    default:
      return MaterialPageRoute(
        settings: const RouteSettings(name: '/unknown'),
        builder: (_) => const SplashScreen(),
      );
  }
}
