// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Features/auth/login/screens/login_screen.dart';
import '../../Features/auth/register/screens/admin_address_screen.dart';
import '../../Features/auth/register/screens/register_screen.dart';
import '../../Features/auth/register/screens/set_password_screen.dart';
import '../../Features/auth/reset_password/screens/forget_password_screen.dart';
import '../../Features/auth/reset_password/screens/otp_screen.dart';
import '../../Features/auth/reset_password/screens/set_new_password_screen.dart';
import '../../Features/auth/role_selection/screens/role_selection_screen.dart';
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

    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  }
}
