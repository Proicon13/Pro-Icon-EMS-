import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_svg_visual.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  const CustomErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSvgVisual(
            width: context.setMinSize(196),
            height: context.setMinSize(196),
            assetPath: Assets.assetsImagesErrorIcon),
        context.setMinSize(30).verticalSpace,
        Text(message,
            style: AppTextStyles.fontSize20(context)
                .copyWith(color: AppColors.lightGreyColor)),
      ],
    );
  }
}
