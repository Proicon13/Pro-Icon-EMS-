import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Features/session_managment/session_setup/screens/session_setup_screen.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/theme/app_text_styles.dart';
import '../../../Core/widgets/custom_svg_visual.dart';

class StartIcon extends StatelessWidget {
  const StartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SessionSetupScreen.routeName);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomSvgVisual(
            assetPath: Assets.assetsImagesStartIcon,
            width: context.setMinSize(65),
            height: context.setMinSize(65),
          ),
          Text("start",
              style: AppTextStyles.fontSize12(context)
                  .copyWith(color: Colors.green)),
        ],
      ),
    );
  }
}
