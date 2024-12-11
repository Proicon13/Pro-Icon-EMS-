

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'Core/Routing/app_Router.dart';

class proicon extends StatelessWidget {

  final AppRouter appRouter;

  const proicon({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pro-Icon',

        theme: ThemeData(


        ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}