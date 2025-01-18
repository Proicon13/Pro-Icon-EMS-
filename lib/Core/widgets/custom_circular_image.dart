import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';
import 'custom_network_image.dart';

enum ImageType { network, asset, file }

class CustomCircularImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final ImageType? imageType;
  const CustomCircularImage(
      {super.key,
      required this.width,
      this.imageType = ImageType.network,
      required this.height,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.white71Color, // Border color
          width: context.setMinSize(3), // Border width
        ),
      ),
      child: ClipOval(
        child: imageType != null && imageType == ImageType.file
            ? Image.file(File(imageUrl))
            : CustomNetworkImage(
                imageUrl: imageUrl,
                errorAssetPath: Assets.assetsImagesLogo,
              ),
      ),
    );
  }
}
