import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();
  static final appTheme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: AppColors.primaryColor,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor, // Primary color (e.g., red)
      onPrimary: Colors.white, // Text on primary elements

      surface: AppColors.darkGreyColor, // Background color of dialogs
      onSurface: Colors.white, // Text color in the picker
    ),
    datePickerTheme: DatePickerThemeData(
      dividerColor: AppColors.lightGreyColor,
      backgroundColor: AppColors.darkGreyColor, // DatePicker background
      surfaceTintColor: AppColors.darkGreyColor, // Remove tint effect
      headerForegroundColor: Colors.white, // Header text color
      yearForegroundColor: WidgetStateProperty.all(Colors.white),
      dayForegroundColor: WidgetStateProperty.all(Colors.white),
      todayForegroundColor: WidgetStateProperty.all(Colors.white),
      todayBackgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
    ),
  );
}
