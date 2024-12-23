import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
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
    return SizedBox(
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.darkGreyColor,
                border: isSelected
                    ? Border.all(
                        color: AppColors.primaryColor,
                        width: 2,
                      )
                    : Border.all(color: Colors.transparent),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 0.84,
                    child: CustomAssetImage(
                      path: imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  10.h.verticalSpace,
                  Text(
                    title,
                    style: AppTextStyles.fontSize16.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected)
            Positioned(
                top: 10.h,
                right: 10.w,
                child: CustomSvgVisual(
                  height: 24.h,
                  width: 24.w,
                  assetPath: Assets.assetsIconsSelectedIcon,
                )),
        ],
      ),
    );
  }
}
