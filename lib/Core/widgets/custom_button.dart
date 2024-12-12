import 'package:flutter/material.dart';
import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  const CustomButton(
      {super.key, required this.onPressed, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: color ?? AppColors.primaryColor,
      child: Text(text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          )),
    );
  }
}
