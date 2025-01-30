import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_circular_image.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class SessionCardSummary extends StatelessWidget {
  //TODO: fix naming conventions
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

  const SessionCardSummary(
      {Key? key,
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
      required,
      required this.SvgPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      baseSize: const Size(398, 150),
      width: context.setMinSize(398),
      height: context.setMinSize(150),
      child: Builder(
        builder: (context) {
          return Container(
            width: context.sizeConfig.width,
            height: context.sizeConfig.height,
            padding: EdgeInsets.symmetric(
                horizontal: context.setMinSize(16),
                vertical: context.setMinSize(14)),
            decoration: BoxDecoration(
              color: AppColors.darkGreyColor,
              borderRadius: BorderRadius.circular(context.setMinSize(10)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCircularImage(
                  width: context.setMinSize(50),
                  height: context.setMinSize(50),
                  imageUrl: imageUrl,
                ),
                context.setMinSize(15).horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TODO: NAME DETAILS ROW
                      _buildNameRow(context),
                      context.setMinSize(10).verticalSpace,
                      _buildHeightWeightRow(context),
                      context.setMinSize(20).verticalSpace,
                      Row(
                        children: [
                          // TODO: EXTRACT TO SEPERATE WIDGET (ICONPATH,TITLE )
                          Column(
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
                                    "Min:${MinNumber}",
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
                                    "Max: ${MaxNumber}",
                                    style: AppTextStyles.fontSize14(context)
                                        .copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          ),
                          context.setMinSize(40).horizontalSpace,
                          Column(
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
                                    "${KalNumber} Kal",
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
                                    PrizeNumber,
                                    style: AppTextStyles.fontSize14(context)
                                        .copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Row _buildHeightWeightRow(BuildContext context) {
    return Row(
      children: [
        //TODO: put sizes for icons
        const CustomSvgVisual(assetPath: Assets.assetsSessionUserAgeIcon),
        context.setMinSize(10).horizontalSpace,
        Text(
          "${userAge} y.o",
          style: AppTextStyles.fontSize14(context)
              .copyWith(color: AppColors.white71Color),
        ),
        context.setMinSize(10).horizontalSpace,
        const CustomSvgVisual(
          assetPath: Assets.assetsSessionUserHeightIcon,
        ),
        context.setMinSize(10).horizontalSpace,
        Text("${userHeight} Cm",
            style: AppTextStyles.fontSize14(context)
                .copyWith(color: AppColors.white71Color)),
        context.setMinSize(10).horizontalSpace,
        const CustomSvgVisual(assetPath: Assets.assetsSessionUserweightIcon),
        context.setMinSize(10).horizontalSpace,
        Text("${userWeight}Kg",
            style: AppTextStyles.fontSize14(context)
                .copyWith(color: AppColors.white71Color))
      ],
    );
  }

  Widget _buildNameRow(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ensures bounded width
      child: Row(
        children: [
          Expanded(
            child: Text(
              userName,
              style: AppTextStyles.fontSize16(context)
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis, // Prevents text overflow
            ),
          ),
          Row(
            children: [
              const CustomSvgVisual(
                assetPath: Assets.assetsImagesMadsIcon,
                width: 18,
                color: Colors.grey,
              ),
              context.setMinSize(10).horizontalSpace,
              Text(
                "MAD No : $madsCount",
                style: AppTextStyles.fontSize14(context)
                    .copyWith(color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
