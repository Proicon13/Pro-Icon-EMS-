import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();
  static final appTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: AppColors.primaryColor,
    useMaterial3: true,
  );
}
