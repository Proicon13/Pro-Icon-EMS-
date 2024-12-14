import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/pro_icon_app.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies();
  runApp(const Proicon());
}
