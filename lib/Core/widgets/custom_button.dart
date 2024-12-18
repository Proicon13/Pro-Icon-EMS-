import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

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
      padding: EdgeInsets.symmetric(
        vertical: 15.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: color ?? AppColors.primaryColor,
      child: Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          )),
    );
  }
}
