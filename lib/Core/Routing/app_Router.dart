// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Features/manage_trainer/screens/trainer_password_regestraion_screen.dart';

import '../../Features/auth/login/screens/login_screen.dart';
import '../../Features/auth/register/screens/admin_address_screen.dart';
import '../../Features/auth/register/screens/register_screen.dart';
import '../../Features/auth/register/screens/set_password_screen.dart';
import '../../Features/auth/reset_password/screens/forget_password_screen.dart';
import '../../Features/auth/reset_password/screens/otp_screen.dart';
import '../../Features/auth/reset_password/screens/set_new_password_screen.dart';
import '../../Features/auth/role_selection/screens/role_selection_screen.dart';
import '../../Features/manage_trainer/screens/manage_trainer_screen.dart';
import '../../Features/users/screens/users_screen.dart';
import '../../splash_screen.dart';

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

    case UsersScreen.routeName:
      return MaterialPageRoute(
        settings: const RouteSettings(name: UsersScreen.routeName),
        builder: (_) => const UsersScreen(),
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

    default:
      return MaterialPageRoute(
        settings: const RouteSettings(name: '/unknown'),
        builder: (_) => const SplashScreen(),
      );
  }
}
