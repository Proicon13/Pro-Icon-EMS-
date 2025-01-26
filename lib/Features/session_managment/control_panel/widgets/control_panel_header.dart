import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_asset_image.dart';

class ControlPanelHeader extends StatelessWidget {
  const ControlPanelHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        context.setMinSize(16).horizontalSpace,
        GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: context.setSp(24), // Responsive size for the icon
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        // Pushes the title to the center
        Expanded(
            child: SizeConfig(
          baseSize: const Size(128, 40),
          width: context.setMinSize(128), // width of logo
          height: context.setMinSize(40), // height of logo
          child: Builder(builder: (context) {
            //new context to get parent size
            return SizedBox(
              width: context.sizeConfig.width, // take full scaled width
              child: const AspectRatio(
                aspectRatio: 3.6,
                child: CustomAssetImage(
                  path: Assets.assetsImagesLogo,
                  fit: BoxFit.contain,
                ),
              ),
            );
          }),
        )),
        // Ensures symmetry on the right
      ],
    );
  }
}
