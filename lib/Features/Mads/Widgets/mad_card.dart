import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/data/models/mad.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/theme/app_colors.dart';
import '../../../Core/theme/app_text_styles.dart';
import '../../../Core/widgets/custom_svg_visual.dart';

class MadCard extends StatelessWidget {
  final Mad mad;
  final void Function()? onTap;
  final void Function()? onDeactivate;
  const MadCard({super.key, required this.mad, this.onTap, this.onDeactivate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.sizeConfig.width,
        height: context.sizeConfig.height,
        decoration: BoxDecoration(
          color: AppColors.darkGreyColor,
          borderRadius: BorderRadius.circular(context.setMinSize(8)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: context.setMinSize(10),
          horizontal: context.setMinSize(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomSvgVisual(
              assetPath: Assets.assetsImagesMadIcon,
              width: context.setMinSize(35),
              height: context.setMinSize(35),
            ),
            context.setMinSize(20).horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.setMinSize(20).verticalSpace,
                  Text(
                    "No . ${mad.serialNo}",
                    style: AppTextStyles.fontSize16(context)
                        .copyWith(color: Colors.white),
                  ),
                  context.setMinSize(8).verticalSpace,
                  Row(
                    children: [
                      CustomSvgVisual(
                        assetPath: Assets.assetsImagesDumbleIcon,
                        width: context.setMinSize(20),
                        height: context.setMinSize(20),
                      ),
                      context.setMinSize(8).horizontalSpace,
                      Text(
                        "5 Sessions",
                        style: AppTextStyles.fontSize16(context)
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  context.setMinSize(8).verticalSpace,
                  Container(
                    width: context.setMinSize(90),
                    padding: EdgeInsets.symmetric(
                      vertical: context.setMinSize(5),
                    ),
                    decoration: BoxDecoration(
                      color: mad.isActive ? Colors.green : Colors.red,
                      borderRadius:
                          BorderRadius.circular(context.setMinSize(8)),
                    ),
                    child: Center(
                      child: Text(
                        mad.isActive ? "Active" : "Not Active",
                        style: AppTextStyles.fontSize14(context).copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.lightGreyColor,
                ),
                GestureDetector(
                  onTap: onDeactivate,
                  child: const CustomSvgVisual(
                    assetPath: Assets.assetsImagesPowerIcon,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
