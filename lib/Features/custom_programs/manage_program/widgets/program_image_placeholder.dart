import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class ProfileImagePlaceholder extends StatelessWidget {
  const ProfileImagePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            Container(
                height: context.setMinSize(65),
                width: context.setMinSize(65),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lightGreyColor,
                  border: Border.all(
                    color: AppColors.white71Color, // Border color
                    width: context.setMinSize(3), // Border width
                  ),
                ),
                child: Center(
                  child: CustomSvgVisual(
                    assetPath: Assets.assetsImagesCameraIcon,
                    width: context.setMinSize(32),
                    height: context.setMinSize(32),
                  ),
                )),
            Positioned(
              bottom: 0,
              left: 0,
              child: CustomSvgVisual(
                assetPath: Assets.assetsImagesEditProfileIcon,
                width: context.setMinSize(30),
                height: context.setMinSize(30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
