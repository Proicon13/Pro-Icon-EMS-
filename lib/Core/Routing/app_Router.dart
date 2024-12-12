import 'package:flutter/material.dart';

import '../../splash_screen.dart';
import '../Auth/Register/Sign_up.dart';
import 'Routes.dart';

Route<dynamic>? onGenerteRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.SplashScreen:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case Routes.onBoardingScreen:
      return MaterialPageRoute(builder: (_) => const Text("On boarding"));

    case Routes.loginScreen:
      return MaterialPageRoute(builder: (_) => const SignUp());

    case Routes.registerScreen:
      return MaterialPageRoute(builder: (_) => const Text("register Screen"));

    default:
      return null;
  }
}
