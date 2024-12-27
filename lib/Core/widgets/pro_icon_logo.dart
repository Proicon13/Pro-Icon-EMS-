import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../constants/app_assets.dart';
import '../utils/responsive_helper/size_config.dart';
import 'custom_asset_image.dart';

class ProIconLogo extends StatelessWidget {
  const ProIconLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      baseSize: const Size(200, 60),
      width: context.setMinSize(200), // width of logo
      height: context.setMinSize(60), // height of logo
      child: Builder(builder: (context) {
        //new context to get parent size
        return SizedBox(
          width: context.sizeConfig.width, // take full scaled width
          child: const AspectRatio(
            aspectRatio: 3.6,
            child: CustomAssetImage(
              path: Assets.assetsImagesLogo,
            ),
          ),
        );
      }),
    );
  }
}
