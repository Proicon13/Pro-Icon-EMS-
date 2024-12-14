import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/Theming/app_text_styles.dart';
import '../../../../core/Theming/Colors/app_colors.dart';
import '../../Admin/admin_register_screen.dart';

class DontHaveAccountRow extends StatelessWidget {
  const DontHaveAccountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: AppTextStyles.fontSize14
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, AdminRegisterScreen.routeName),
          child: Text(
            "Sign up",
            style: AppTextStyles.fontSize14.copyWith(
              color: AppColors.primaryColor, // Highlighted color for the link
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
