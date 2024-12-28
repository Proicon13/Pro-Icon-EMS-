import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
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
        CustomSvgVisual(
            width: context.setMinSize(242),
            height: context.setMinSize(237),
            assetPath: Assets.assetsImagesEmptyStateIcon),
        context.setMinSize(30).verticalSpace,
        Text(message,
            style: AppTextStyles.fontSize20(context)
                .copyWith(color: AppColors.lightGreyColor)),
      ],
    );
  }
}
