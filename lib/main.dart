import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/pro_icon_app.dart';
import 'Core/Routing/app_Router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(proicon(appRouter: AppRouter(),));
}



