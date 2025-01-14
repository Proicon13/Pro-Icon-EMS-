
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';

  class CardRequest extends StatelessWidget {
    const CardRequest({super.key});

    @override
    Widget build(BuildContext context) {
      return SizeConfig(
        baseSize: const Size(398, 85),
        width: context.setMinSize(398),
        height: context.setMinSize(85),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: context.sizeConfig.width,
                height: context.sizeConfig.height,
                decoration: BoxDecoration(
                  color: AppColors.darkGreyColor,
                  borderRadius: BorderRadius.circular(context.setMinSize(8)),
                ),
                child: Row(
                  children: [
                    context.setMinSize(20).horizontalSpace,
                    Image(image: AssetImage(Assets.assetsIconForCard)),
                    context.setMinSize(10).horizontalSpace,
                    Padding(
                      padding:  EdgeInsets.all(context.setMinSize(8)),
                      child: Column(
                        children: [
                          context.setMinSize(10).verticalSpace,
                          Text(
                            "id:45",
                            style: AppTextStyles.fontSize16(context).copyWith(color: Colors.white),
                          ),
                          context.setMinSize(10).verticalSpace,
                          Text(
                            "date:22-1-2025",
                            style: AppTextStyles.fontSize14(context).copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    context.setMinSize(20).horizontalSpace,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: context.setMinSize(77),
                          height: context.setMinSize(25),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Pending",
                              style: AppTextStyles.fontSize14(context).copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
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