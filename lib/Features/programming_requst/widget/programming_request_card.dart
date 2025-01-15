import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';
import 'package:pro_icon/data/models/programming_request.dart';

class ProgrammingRequestCard extends StatelessWidget {
  final ProgrammingRequest programmingRequest;
  const ProgrammingRequestCard({super.key, required this.programmingRequest});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          width: context.sizeConfig.width,
          height: context.sizeConfig.height,
          margin: EdgeInsets.only(top: context.setMinSize(30)),
          padding: EdgeInsets.symmetric(
              horizontal: context.setMinSize(16),
              vertical: context.setMinSize(12)),
          decoration: BoxDecoration(
            color: AppColors.darkGreyColor,
            borderRadius: BorderRadius.circular(context.setMinSize(8)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Section
              CustomSvgVisual(
                assetPath: Assets.assetsImagesMyProgramsIcon,
                width: context.setMinSize(40),
                height: context.setMinSize(40),
              ),
              context.setMinSize(20).horizontalSpace,

              // Information Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Id:${programmingRequest.id}",
                      style: AppTextStyles.fontSize16(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    context.setMinSize(4).verticalSpace,
                    Row(
                      children: [
                        CustomSvgVisual(
                          assetPath: Assets.assetsImagesCalendarIcon,
                          width: context.setMinSize(20),
                          height: context.setMinSize(20),
                        ),
                        context.setMinSize(8).horizontalSpace,
                        Text(
                          programmingRequest.createdAt!
                              .toIso8601String()
                              .split("T")[0]
                              .replaceAll("-", "/"),
                          style: AppTextStyles.fontSize14(context).copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              context.setMinSize(10).horizontalSpace,

              // Status Section
              Container(
                height: context.setMinSize(30),
                padding: EdgeInsets.symmetric(
                  horizontal: context.setMinSize(6),
                  vertical: context.setMinSize(4),
                ),
                decoration: BoxDecoration(
                  color: programmingRequest.status == "PENDING"
                      ? Colors.yellow
                      : programmingRequest.status == "APPROVED"
                          ? Colors.green
                          : Colors.red,
                  borderRadius: BorderRadius.circular(context.setMinSize(8)),
                ),
                child: Center(
                  child: Text(
                    programmingRequest.status!.toLowerCase(),
                    style: AppTextStyles.fontSize14(context).copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
