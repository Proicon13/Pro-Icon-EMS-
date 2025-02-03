import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_rectaungular_image.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class AutoSessionCard extends StatelessWidget {
  final String title;
  final String hzValue;
  final String puValue;
  final String madsCount;
  final String duration;
  final String imageUrl;

  AutoSessionCard(
      {super.key,
      required this.title,
      required this.hzValue,
      required this.puValue,
      required this.madsCount,
      required this.duration,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.sizeConfig.height,
      padding: EdgeInsets.all(context.setMinSize(12)),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(context.setMinSize(16)),
      ),
      child: Row(
        children: [
          CustomRectangularImage(
              width: context.setMinSize(81),
              height: context.setMinSize(79),
              imageUrl: imageUrl),
          context.setMinSize(15).horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.fontSize16(context)
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              context.setMinSize(7).verticalSpace,
              Row(
                children: [
                  Text(
                    hzValue,
                    style: AppTextStyles.fontSize14(context)
                        .copyWith(color: Colors.white),
                  ),
                  context.setMinSize(10).horizontalSpace,
                  const CustomSvgVisual(
                      assetPath: Assets.assetsImagesPulseIcon),
                  context.setMinSize(10).horizontalSpace,
                  Text(
                    puValue,
                    style: AppTextStyles.fontSize14(context)
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
              context.setMinSize(10).verticalSpace,
              Row(
                children: [
                  Row(
                    children: [
                      CustomSvgVisual(
                        assetPath: Assets.assetsImagesMadsIcon,
                        width: context.setMinSize(16),
                        height: context.setMinSize(16),
                      ),
                      context.setMinSize(10).horizontalSpace,
                      Text(
                        madsCount,
                        style: AppTextStyles.fontSize14(context)
                            .copyWith(color: Colors.grey),
                      )
                    ],
                  ),
                  context.setMinSize(40).horizontalSpace,
                  Row(
                    children: [
                      const CustomSvgVisual(
                          assetPath: Assets.assetsImagesDurationIcon),
                      context.setMinSize(10).horizontalSpace,
                      Text(duration,
                          style: AppTextStyles.fontSize14(context)
                              .copyWith(color: Colors.grey))
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
