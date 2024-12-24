import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final textStyle = AppTextStyles.fontSize16.copyWith(
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

              return Column(
                children: [
                  Text(
                    userVariation,
                    style: textStyle,
                  ),
                  5.h.verticalSpace,
                  isSelected
                      ? Container(
                          width: textWidth.width,
                          height: 3.h,
                          color: AppColors.primaryColor,
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
