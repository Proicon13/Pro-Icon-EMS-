import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/pro_icon_app.dart';

import 'Core/localization/locales.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: supportedLocales,
      fallbackLocale: supportedLocales.first, // en
      child: const Proicon()));
}
