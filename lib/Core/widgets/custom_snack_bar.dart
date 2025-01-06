import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';

void buildCustomSnackBar(BuildContext context, String message, Color color,
    [Duration? duration]) {
  final snackBar = SnackBar(
    duration: duration ?? const Duration(seconds: 2),
    content: Text(
      message,
      style: AppTextStyles.fontSize14.copyWith(fontWeight: FontWeight.w500),
    ),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
