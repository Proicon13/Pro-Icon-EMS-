import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String errorAssetPath;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    required this.errorAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Skeletonizer(
        child: Container(
          color: Colors.grey[300],
        ),
      ),
      errorWidget: (context, url, error) => DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.darkGreyColor),
        child: Center(
          child: Image.asset(
            Assets.assetsImagesLogo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
