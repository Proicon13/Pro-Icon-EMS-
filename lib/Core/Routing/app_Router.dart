

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../splash_screen.dart';

import '../Auth/Register/Sign_up.dart';
import 'Routes.dart';

class AppRouter
{
  Route ?generateRoute (RouteSettings settings){

    switch (settings.name)
    {

      case Routes.SplashScreen :

        return MaterialPageRoute(builder: (_) => SplashScreen() );

      case Routes.onBoardingScreen :
        return MaterialPageRoute(builder: (_) => Text("On boarding") );

      case Routes.loginScreen:
        return  MaterialPageRoute(builder: (context) => SignUp());

      case Routes.registerScreen:
        return  MaterialPageRoute(builder: (_) => Text("register Screen") );




    }


  }
}