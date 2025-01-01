import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../../../Core/theme/app_colors.dart';
import '../../../Core/theme/app_text_styles.dart';

class UserVariationColumn extends StatelessWidget {
  final String userVariation;
  final bool isSelected;
  final Function() onTap;
  const UserVariationColumn({
    super.key,
    required this.userVariation,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.fontSize16(context).copyWith(
      color: isSelected ? Colors.white : AppColors.lightGreyColor,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
    );

    final textWidth = TextPainter(
      text: TextSpan(
        text: userVariation,
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            userVariation,
            style: textStyle,
          ),
          context.setMinSize(5).verticalSpace,
          isSelected
              ? Container(
                  width: textWidth.width,
                  height: context.setMinSize(3),
                  color: AppColors.primaryColor,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
