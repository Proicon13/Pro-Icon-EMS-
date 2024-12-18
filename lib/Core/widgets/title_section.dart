import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20.h,
      children: [
        Text(
          title,
          style: AppTextStyles.fontSize24.copyWith(color: Colors.white),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.left,
          style:
              AppTextStyles.fontSize14.copyWith(color: AppColors.white71Color),
        ),
      ],
    );
  }
}
