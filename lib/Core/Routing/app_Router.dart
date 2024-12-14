// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pro_icon/Features/auth/Admin/account_Created.dart';
import 'package:pro_icon/Features/auth/Trainer/forgot_password_screen.dart';
import 'package:pro_icon/Features/auth/Trainer/reset_password_screen.dart';
import 'package:pro_icon/Features/auth/role_selection/role_selection_screen.dart';

import '../../Features/auth/login/login_screen.dart';
import '../../Features/auth/Admin/admin_address_screen.dart';
import '../../Features/auth/register/register_screen.dart';
import '../../Features/auth/Admin/confirm_admin_password.dart';
import '../../Features/auth/Trainer/confirm_trainer_password_screen.dart';
import '../../Features/auth/Trainer/otp_screen.dart';
import '../../Features/auth/Trainer/trainer.dart';
import '../../splash_screen.dart';

Route<dynamic>? onGenerteRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case RoleSelectionScreen.routeName:
      return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    case OtpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const OtpScreen());

    case TrainerAuth.routeName:
      return MaterialPageRoute(builder: (_) => const TrainerAuth());
    case RegisterScreen.routeName:
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    case AdminAdressScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminAdressScreen());
    case AccountCreatedScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AccountCreatedScreen());
    case ConfirmAdminPassword.routeName:
      return MaterialPageRoute(builder: (_) => const ConfirmAdminPassword());
    case ConfirmTrainerPasswordScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const ConfirmTrainerPasswordScreen());
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
    case ResetPasswordScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  }
}
