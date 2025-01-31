import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class MinandmaxSection extends StatelessWidget {

  final String minNumber;
  final String maxNumber;

   MinandmaxSection({super.key, required this.minNumber, required this.maxNumber});

  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomSvgVisual(
              assetPath:
              Assets.assetsSessionSummaryHeartIcon,
              width: context.setMinSize(20),
              height: context.setMinSize(20),
            ),
            context.setMinSize(10).horizontalSpace,
            Text(
              "Min:${minNumber}",
              style: AppTextStyles.fontSize14(context)
                  .copyWith(color: Colors.grey),
            )
          ],
        ),
        context.setMinSize(10).verticalSpace,
        Row(
          children: [
            CustomSvgVisual(
              assetPath:
              Assets.assetsSessionSummaryHeartIcon,
              width: context.setMinSize(20),
              height: context.setMinSize(20),
            ),
            context.setMinSize(10).horizontalSpace,
            Text(
              "Max: ${maxNumber}",
              style: AppTextStyles.fontSize14(context)
                  .copyWith(color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}
