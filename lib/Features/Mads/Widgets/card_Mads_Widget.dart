import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
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
              child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:   [
                  Padding(
                    padding:  EdgeInsets.only(bottom: context.setMinSize(20)),
                    child: CustomSvgVisual(
                      assetPath: Assets.assetsMadsIconSvg,
                      width: context.setMinSize(35),
                      height: context.setMinSize(35),
                    ),
                  ),
                   context.setMinSize(12).horizontalSpace,
                   Padding(
                     padding:  EdgeInsets.only(top: context.setMinSize(20)),
                     child: Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("No . 1234567" , style: AppTextStyles.fontSize16(context).copyWith(
                            color: Colors.white
                          ),),
                          context.setMinSize(8).verticalSpace,
                          Row(
                            children: [
                              CustomSvgVisual(assetPath: Assets.assetsForMadsIconSvg , width: 15, height: 15,),
                              context.setMinSize(8).horizontalSpace,
                              Text("5 Sessions" , style: AppTextStyles.fontSize16(context).copyWith(
                                color: Colors.white
                              ),)
                            ],
                          ),
                        context.setMinSize(3).verticalSpace,
                        SizeConfig(
                          baseSize: Size(68, 24),
                          width: context.setMinSize(68),
                          height: context.setMinSize(24),
                          child: Builder(
                            builder: (context) {
                              return Container(
                                width: context.sizeConfig.width ,
                                  height: context.setMinSize(24),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(context.setMinSize(8))
                                  ),
                                  child:    Center(
                                    child: Text("Active" , style: AppTextStyles.fontSize14(context).copyWith(
                                      color: Colors.white
                                    ),),
                                  )
                              );
                            }
                          ),
                        )
                       
                        ],
                       ),
                     ),
                   ),
                  context.setMinSize(150).horizontalSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: context.setMinSize(20)),
                        child: CustomSvgVisual(assetPath: Assets.assetsForMadsarrowIcon),
                      ),
                      CustomSvgVisual(assetPath: Assets.assetsForPowerMads)
                    ],
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
