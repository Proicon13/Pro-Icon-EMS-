import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/widgets/custom_asset_image.dart';

class RoleCard extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.isSelected,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = context.sizeConfig.height;
    final cardWidth = context.sizeConfig.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.setMinSize(8)),
          color: AppColors.darkGreyColor,
          border: isSelected
              ? Border.all(
                  color: AppColors.primaryColor,
                  width: context.setMinSize(2),
                )
              : Border.all(color: Colors.transparent),
        ),
        child: Stack(
          children: [
            // Amber background
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: cardWidth * 0.70,
                    height: cardHeight * 0.70,
                    child: CustomAssetImage(
                      path: imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  context.setMinSize(10).verticalSpace,
                  Text(
                    title,
                    style: AppTextStyles.fontSize16(context).copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Selected icon
            if (isSelected)
              Positioned(
                top: context.setMinSize(10),
                right: context.setMinSize(10),
                child: CustomSvgVisual(
                  height: context.setMinSize(24),
                  width: context.setMinSize(24),
                  assetPath: Assets.assetsImagesSelectedIcon,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
