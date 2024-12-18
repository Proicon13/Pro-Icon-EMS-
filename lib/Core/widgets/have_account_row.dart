import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Theming/Colors/app_colors.dart';
import '../theme/app_text_styles.dart';

class HaveAccountRow extends StatelessWidget {
  const HaveAccountRow({
    super.key,
    required this.title,
    required this.action,
    required this.onAction,
  });
  final String title;
  final String action;
  final Function() onAction;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5.w,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.fontSize14
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: onAction,
          child: Text(
            action,
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
