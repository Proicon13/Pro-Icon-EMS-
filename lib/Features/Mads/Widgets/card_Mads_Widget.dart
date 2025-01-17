import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../Core/theme/app_colors.dart';
import '../../../Core/utils/responsive_helper/size_config.dart';

class CardMadsWidget extends StatefulWidget {
  //TODO: use named routes for navigation (add route name here)

  const CardMadsWidget({super.key});

  @override
  State<CardMadsWidget> createState() => _CardMadsWidgetState();
}

class _CardMadsWidgetState extends State<CardMadsWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO:recode this screen to use sizeconfig for responsive
    // TODO:Done Used  this screen to use sizeconfig for responsive

    return SizeConfig(
      baseSize: const Size(398, 145),
      width: context.setMinSize(398),
      height: context.setMinSize(145),
      child: Builder(builder: (context) {
        return Container(
          width: context.sizeConfig.width,
          height: context.sizeConfig.height,
          child: Card(
            color: AppColors.darkGreyColor,
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.setMinSize(10),
                  horizontal: context.setMinSize(20)),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ), // use responsive spacing in all widgets
                      CustomSvgVisual(
                        assetPath: Assets.assetsMadsIconSvg,
                        width: context.setMinSize(35),
                        height: context.setMinSize(35),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text('NO.123456798123',
                          style: AppTextStyles.fontSize16(context)
                              .copyWith(color: Colors.white)),
                      const SizedBox(
                        width: 70,
                      ),
                      SvgPicture.asset(
                          Assets.assetsForMadsarrowIcon) // use customSvgVisual
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      SvgPicture.asset(
                        Assets.assetsSessionIcon,
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text('5 sessions',
                          style: AppTextStyles.fontSize14(context)
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: context.setMinSize(80),
                          height: context.setMinSize(25),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Active",
                              style: AppTextStyles.fontSize14(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // الأيقونة SVG
                        SvgPicture.asset(
                          Assets.assetsForPowerMads,
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
