import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) => Skeletonizer(
          child: Container(
            color: Colors.grey[300],
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: AppColors.darkGreyColor,
          child: Center(
            child: Image.asset(
              errorAssetPath,
              fit: BoxFit.contain,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
            ),
          ),
        ),
      );
    });
  }
}
