// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pro_icon/Features/auth/Admin/account_Created.dart';
import 'package:pro_icon/Features/auth/Trainer/forgot_password_screen.dart';
import 'package:pro_icon/Features/auth/Trainer/reset_password_screen.dart';
import 'package:pro_icon/Features/auth/role_selection/role_selection_screen.dart';

import '../../Features/auth/login/login_screen.dart';
import '../../Features/auth/register/admin_address_screen.dart';
import '../../Features/auth/register/register_screen.dart';
import '../../Features/auth/Admin/confirm_admin_password.dart';
import '../../Features/auth/Trainer/confirm_trainer_password_screen.dart';

import '../../Features/auth/register/set_password_screen.dart';
import '../../Features/auth/reset_password/forget_password_screen.dart';
import '../../Features/auth/reset_password/otp_screen.dart';
import '../../Features/auth/reset_password/set_new_password_screen.dart';
import '../../splash_screen.dart';

Route<dynamic>? onGenerteRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case RoleSelectionScreen.routeName:
      return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case SetPasswordScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SetPasswordScreen());
    case ForgetPasswordScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

    case OtpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const OtpScreen());

    case SetNewPasswordScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SetNewPasswordScreen());

    case RegisterScreen.routeName:
      return MaterialPageRoute(builder: (_) => const RegisterScreen());
    case AdminAddressScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminAddressScreen());
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
