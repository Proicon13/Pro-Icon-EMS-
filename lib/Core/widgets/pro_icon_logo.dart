import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_assets.dart';
import 'custom_asset_image.dart';

class ProIconLogo extends StatelessWidget {
  const ProIconLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: const AspectRatio(
        aspectRatio: 3.6,
        child: CustomAssetImage(
          path: Assets.assetsImagesLogo,
        ),
      ),
    );
  }
}
