import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class KalAndPrizeSecion extends StatelessWidget {

  final String kalNumber;
  final String prizeNumber;


   KalAndPrizeSecion({super.key, required this.kalNumber, required this.prizeNumber});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomSvgVisual(
              assetPath:
              Assets.assetsSessionSummaryKalIcon,
              width: context.setMinSize(20),
              height: context.setMinSize(20),
            ),
            context.setMinSize(15).horizontalSpace,
            Text(
              "${kalNumber} Kal",
              style: AppTextStyles.fontSize14(context)
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
        context.setMinSize(10).verticalSpace,
        Row(
          children: [
            CustomSvgVisual(
              assetPath:
              Assets.assetsSessionSummaryChampion,
              width: context.setMinSize(20),
              height: context.setMinSize(20),
            ),
            context.setMinSize(10).horizontalSpace,
            Text(
              prizeNumber,
              style: AppTextStyles.fontSize14(context)
                  .copyWith(color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}
