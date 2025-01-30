import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_circular_image.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_rectaungular_image.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class SessionCardSummary extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String madsCount;
  final String duration;
  final String userAge;
  final String userHeight;
  final String userWeight;
  final String MinNumber;
  final String MaxNumber;
  final String KalNumber;
  final String PrizeNumber;
  final String SvgPath;


  const SessionCardSummary({
    Key? key,
    required this.imageUrl,
    required this.userAge,
    required this.userHeight,
    required this.userWeight,
    required this.userName,
    required this.madsCount,
    required this.duration,
    required this.MinNumber,
    required this.MaxNumber,
    required this.KalNumber,
    required this.PrizeNumber,
    required, required this.SvgPath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      baseSize: const Size(420, 180),
      width: context.setMinSize(420),
      height: context.setMinSize(180),
      child: Builder(
        builder: (context) {
          return Container(
            width: context.sizeConfig.width,
            height: context.sizeConfig.height,
            decoration: BoxDecoration(
              color: AppColors.darkGreyColor,
              borderRadius: BorderRadius.circular(context.setMinSize(16)),
            ),
            child: Padding(
              padding: EdgeInsets.all(context.setMinSize(8)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: CustomCircularImage(
                      width: context.setMinSize(50),
                      height: context.setMinSize(50),
                      imageUrl: imageUrl,
                    ),
                  ),
                  context.setMinSize(15).horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(

                          children: [
                            Text(
                              userName,
                              style: AppTextStyles.fontSize16(context).copyWith(
                                color: Colors.white,
                              ),
                            ),
                          context.setMinSize(70).horizontalSpace,
                          Row(
                          children: [
                         const    CustomSvgVisual(assetPath: Assets.assetsImagesMadsIcon , width: 18,color: Colors.grey,),
                          context.setMinSize(20).horizontalSpace,
                          Text("MAD No : 1" , style: AppTextStyles.fontSize14(context).copyWith(
                        color: Colors.grey
                        ),)
                          ],
                          ),
                          ],
                        ),
                      ),
                      context.setMinSize(20).verticalSpace,
                    Row(
                      children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10 , bottom: 10),
                      child: CustomSvgVisual(assetPath: Assets.assetsSessionUserAgeIcon),
                    ),
                        context.setMinSize(10).horizontalSpace,
                        Text("${userAge} y.o" , style: AppTextStyles.fontSize14(context).copyWith(
                          color: Colors.grey
                        ),),

                        context.setMinSize(10).horizontalSpace,
                        CustomSvgVisual(assetPath: Assets.assetsSessionUserHeightIcon , color: Colors.grey,),
                        context.setMinSize(10).horizontalSpace,
                        Text("${userHeight} Cm" ,  style: AppTextStyles.fontSize14(context).copyWith(
                            color: Colors.grey
                        )),
                        context.setMinSize(10).horizontalSpace,
                        CustomSvgVisual(assetPath: Assets.assetsSessionUserweightIcon),
                        context.setMinSize(10).horizontalSpace,
                        Text("${userWeight}Kg" ,  style: AppTextStyles.fontSize14(context).copyWith(
                            color: Colors.grey
                        ))
                      ],
                    ),
                      Row(
                        children: [
                          Row(
                            children: [
                            CustomSvgVisual(assetPath: SvgPath , width: context.setMinSize(10),),
                              context.setMinSize(10).horizontalSpace,
                              Text("Min:${MinNumber}" , style: AppTextStyles.fontSize14(context).copyWith(color: Colors.grey),)
                            ],
                          ),
                  context.setMinSize(30).horizontalSpace,

                          Row(
                    children: [
                       CustomSvgVisual(assetPath: Assets.assetsSessionSummaryKalIcon , width: context.setMinSize(10),),
                      context.setMinSize(8).horizontalSpace,
                      Text("${KalNumber} Kal" ,style: AppTextStyles.fontSize14(context).copyWith(color: Colors.grey),),
                    ],
                  ),
                   
                        ],
                      ),
                    Row(
    children: [
      Row(
    children: [
      CustomSvgVisual(assetPath: Assets.assetsSessionSummaryHeartIcon , width: 10,),
      Text("Max: ${MaxNumber}" , style: AppTextStyles.fontSize14(context).copyWith(
color: Colors.grey
),)
    ],
    ),
      context.setMinSize(20).horizontalSpace,
      
      Row(
    children: [
      CustomSvgVisual(assetPath: Assets.assetsSessionSummaryChampion , width: 10, ),
      context.setMinSize(10).horizontalSpace,
      Text(PrizeNumber , style: AppTextStyles.fontSize14(context).copyWith(
color: Colors.grey
),)
    ],
    ),
    ],
) ,
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}