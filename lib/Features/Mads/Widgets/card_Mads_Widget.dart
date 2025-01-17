import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

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

    return   SizeConfig(
      baseSize: Size(398, 137),
      width: context.setMinSize(398),
      height: context.setMinSize(137),
      child: Builder(
          builder: (context) {
            return Container(
              width: context.sizeConfig.width,
              height: context.sizeConfig.height,
              child: Card(
                color: AppColors.darkGreyColor,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(

                    children: [

                      Row(

                        children: [
                          SizedBox(width: 25,),
                          SvgPicture.asset(Assets.assetsMadsIconSvg),
                          SizedBox(width: 15,),
                          Text(
                              'NO.123456798123',
                              style: AppTextStyles.fontSize16(context).copyWith(
                                  color: Colors.white
                              )
                          ),
                          SizedBox(width: 70,),
                          SvgPicture.asset(Assets.assetsForMadsarrowIcon)
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          SvgPicture.asset(Assets.assetsSessionIcon , width: 15, height: 15,),
                          SizedBox(width: 12,),
                          Text(
                              '5 sessions',
                              style:  AppTextStyles.fontSize14(context).copyWith(
                                  color: Colors.white
                              )
                          ),
                        ],
                      ),
                      SizedBox(height:  8),
                      Padding(
                        padding: const EdgeInsets.only(left: 40 , right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Container(
                              width: 68,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: MaterialButton(
                                onPressed: () {

                                },
                                padding: EdgeInsets.zero,
                                child: Text(
                                  "Active",
                                  style: AppTextStyles.fontSize14(context).copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),


                            SizedBox(width: 10),

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
          }
      ),
    );
  }
}
