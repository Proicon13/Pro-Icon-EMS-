import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class SessionModeCard extends StatelessWidget {
  final Map<String, dynamic> mode;
  final bool isSelected;
  final void Function()? onTap;

  const SessionModeCard({
    Key? key,
    required this.mode,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizeConfig(
        baseSize: const Size(170, 165),
        width: context.setMinSize(170),
        height: context.setMinSize(165),
        child: Builder(
          builder: (context) {
            return Container(
              width: context.sizeConfig.width,
              height: context.sizeConfig.height,
              decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(context.setMinSize(10)),
                border: isSelected
                    ? Border.all(
                        color: Colors.red,
                        width: 2,
                      )
                    : null,
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CustomSvgVisual(
                          assetPath: mode['icon'],
                          width: context.setMinSize(65),
                          height: context.setMinSize(65),
                          color: Colors.white,
                        ),
                      ),
                      context.setMinSize(15).verticalSpace,
                      Text(
                        mode['label'],
                        style: AppTextStyles.fontSize16(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  if (isSelected) // علامة "Selected"
                    Positioned(
                      top: context.setMinSize(10),
                      right: context.setMinSize(10), // توضع العلامة على اليمين
                      child: CustomSvgVisual(
                        assetPath: Assets.assetsImagesSelectedIcon,
                        width: context.setMinSize(24), // حجم الأيقونة
                        height: context.setMinSize(24),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
