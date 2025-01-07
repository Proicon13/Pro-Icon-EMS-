import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';
import 'custom_network_image.dart';

class CustomRectangularImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  const CustomRectangularImage(
      {super.key,
      required this.width,
      required this.height,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(context.setMinSize(12)),
        border: Border.all(
          color: AppColors.white71Color, // Border color
          width: context.setMinSize(3), // Border width
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.setMinSize(12)),
        child: CustomNetworkImage(
          imageUrl: imageUrl,
          errorAssetPath: Assets.assetsImagesLogo,
        ),
      ),
    );
  }
}
