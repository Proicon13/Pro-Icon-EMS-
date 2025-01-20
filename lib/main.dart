import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pro_icon/Core/constants/app_constants.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/pro_icon_app.dart';

import 'Core/localization/locales.dart';
import 'Core/utils/app_bloc_observer.dart';
import 'data/models/mad.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(MadAdapter());

  // Open the boxes you plan to use
  await Hive.openBox<Mad>(AppConstants.madListKey);
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: supportedLocales,
      fallbackLocale: supportedLocales.first, // en
      child: const Proicon()));
}
