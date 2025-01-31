import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class HeightAndWeightRow extends StatelessWidget {
  final String userAge;
  final String userHight;
  final String userWeight;
  HeightAndWeightRow(
      {super.key,
      required this.userAge,
      required this.userHight,
      required this.userWeight});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSvgVisual(
          assetPath: Assets.assetsSessionUserAgeIcon,
          width: context.setMinSize(15),
          height: context.setMinSize(15),
        ),
        context.setMinSize(10).horizontalSpace,
        Text(
          "${userAge} y.o",
          style: AppTextStyles.fontSize14(context)
              .copyWith(color: AppColors.white71Color),
        ),
        context.setMinSize(10).horizontalSpace,
        CustomSvgVisual(
          assetPath: Assets.assetsSessionUserHeightIcon,
          width: context.setMinSize(15),
          height: context.setMinSize(15),
        ),
        context.setMinSize(10).horizontalSpace,
        Text("${userHight} ",
            style: AppTextStyles.fontSize14(context)
                .copyWith(color: AppColors.white71Color)),
        context.setMinSize(10).horizontalSpace,
        CustomSvgVisual(
          assetPath: Assets.assetsSessionUserweightIcon,
          width: context.setMinSize(15),
          height: context.setMinSize(15),
        ),
        context.setMinSize(10).horizontalSpace,
        Text("${userWeight}",
            style: AppTextStyles.fontSize14(context)
                .copyWith(color: AppColors.white71Color))
      ],
    );
  }
}
