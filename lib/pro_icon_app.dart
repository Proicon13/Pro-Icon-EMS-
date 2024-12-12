import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_constants.dart';

import 'Core/Routing/app_Router.dart';

class Proicon extends StatelessWidget {
  const Proicon({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: ThemeData(),
      onGenerateRoute: onGenerteRoute,
    );
  }
}
