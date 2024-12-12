// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pro_icon/Features/Admin/account_Created.dart';
import 'package:pro_icon/Features/Trainer/forgot_password_screen.dart';
import 'package:pro_icon/Features/Trainer/reset_password_screen.dart';
import 'package:pro_icon/role_case.dart';

import '../../Features/Admin/Admin_auth.dart';
import '../../Features/Admin/admin_address_screen.dart';
import '../../Features/Admin/admin_register_screen.dart';
import '../../Features/Admin/confirm_admin_password.dart';
import '../../Features/Trainer/confirm_trainer_password_screen.dart';
import '../../Features/Trainer/otp_screen.dart';
import '../../Features/Trainer/trainer.dart';
import '../../splash_screen.dart';

Route<dynamic>? onGenerteRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case RoleCase.routeName:
      return MaterialPageRoute(builder: (_) => const RoleCase());

    case AdminAuth.routeName:
      return MaterialPageRoute(builder: (_) => const AdminAuth());

    case OtpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const OtpScreen());

    case TrainerAuth.routeName:
      return MaterialPageRoute(builder: (_) => const TrainerAuth());
    case AdminRegisterScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminRegisterScreen());
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
