import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_rectaungular_image.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/entities/automatic_session_entity.dart';

enum SessionMode { main, custom }

class BaseSessionCard extends StatelessWidget {
  final Widget content;
  final void Function() onTap;

  const BaseSessionCard({
    Key? key,
    required this.content,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.sizeConfig.height,
        width: context.sizeConfig.width,
        padding: EdgeInsets.symmetric(
            vertical: context.setMinSize(6),
            horizontal: context.setMinSize(12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.setMinSize(8)),
          color: AppColors.darkGreyColor,
        ),
        child: content,
      ),
    );
  }
}

class MainSessionCard extends StatelessWidget {
  final MainAutomaticSessionEntity session;
  final void Function() onTap;

  const MainSessionCard({
    Key? key,
    required this.session,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSessionCard(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomRectangularImage(
              width: context.setMinSize(50),
              height: context.setMinSize(50),
              imageUrl: session.image ?? ""),
          context.setMinSize(20).horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  session.name ?? "Session",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.fontSize16(context).copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                context.setMinSize(10).verticalSpace,
                Row(
                  children: [
                    CustomSvgVisual(
                        assetPath: Assets.assetsImagesDurationIcon,
                        width: context.setMinSize(16),
                        height: context.setMinSize(16)),
                    context.setMinSize(5).horizontalSpace,
                    Text(
                      session.duration != null
                          ? "${session.duration} Minutes"
                          : "Unknown Duration",
                      style: AppTextStyles.fontSize14(context).copyWith(
                        color: AppColors.lightGreyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomSessionCard extends StatelessWidget {
  final CustomAutomaticSessionEntity session;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final void Function() onTap;

  const CustomSessionCard({
    Key? key,
    required this.session,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSessionCard(
      onTap: onTap,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(session.name ?? "Session",
                    style: AppTextStyles.fontSize16(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                context.setMinSize(10).verticalSpace,
                Row(
                  children: [
                    CustomSvgVisual(
                        assetPath: Assets.assetsImagesDurationIcon,
                        width: context.setMinSize(16),
                        height: context.setMinSize(16)),
                    context.setMinSize(5).horizontalSpace,
                    Text(
                      session.duration != null
                          ? "${session.duration} Minutes"
                          : "Unknown Duration",
                      style: AppTextStyles.fontSize14(context).copyWith(
                        color: AppColors.lightGreyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onEdit,
                child: CustomSvgVisual(
                  assetPath: Assets.assetsImagesEditIcon,
                  width: context.setMinSize(25),
                  height: context.setMinSize(25),
                ),
              ),
              context.setMinSize(10).horizontalSpace,
              GestureDetector(
                onTap: onDelete,
                child: CustomSvgVisual(
                  assetPath: Assets.assetsImagesDeleteIcon,
                  width: context.setMinSize(25),
                  height: context.setMinSize(25),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
