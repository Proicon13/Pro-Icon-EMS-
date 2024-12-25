import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  const EmptyStateWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomSvgVisual(assetPath: Assets.assetsImagesEmptyStateIcon),
        30.h.verticalSpace,
        Text(message,
            style: AppTextStyles.fontSize20
                .copyWith(color: AppColors.lightGreyColor)),
      ],
    );
  }
}
