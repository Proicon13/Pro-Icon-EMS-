import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/theme/app_text_styles.dart';
import '../../../Core/widgets/custom_svg_visual.dart';

class LanguageCard extends StatelessWidget {
  final String languageName;
  final String flagSvg;
  final bool isSelected;
  final void Function() onTap;

  const LanguageCard({
    super.key,
    required this.languageName,
    required this.flagSvg,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomSvgVisual(
        assetPath: flagSvg,
        width: context.setMinSize(30),
        height: context.setMinSize(30),
      ),
      title: Text(
        languageName,
        style: AppTextStyles.fontSize16(context).copyWith(
          color: Colors.white,
        ),
      ),
      trailing: isSelected
          ? CustomSvgVisual(
              assetPath: Assets.assetsSelectedIcon,
              width: context.setMinSize(25),
              height: context.setMinSize(25),
            )
          : null,
      onTap: onTap,
    );
  }
}
