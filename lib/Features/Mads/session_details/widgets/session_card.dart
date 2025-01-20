import 'package:flutter/material.dart';
import 'package:pro_icon/Core/entities/mad_session_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class SessionCard extends StatelessWidget {
  final MadSessionEntity session;
  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.sizeConfig.width,
        height: context.sizeConfig.height,
        padding: EdgeInsets.symmetric(
            horizontal: context.setMinSize(20),
            vertical: context.setMinSize(10)),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(context.setMinSize(8))),
            color: AppColors.darkGreyColor),
        child: _buildSessionItem(
            session.id.toString(),
            session.date!.toIso8601String().split('T')[0],
            session.captainName!,
            context));
  }

  Widget _buildSessionItem(
      String id, String date, String name, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomSvgVisual(
              assetPath: Assets.assetsImagesDumbleIcon,
              width: context.setMinSize(30),
              height: context.setMinSize(30),
            ),
            context.setMinSize(20).horizontalSpace,
            Text(
              "ID. $id",
              style: AppTextStyles.fontSize16(context).copyWith(
                color: Colors.white,
              ),
            ),
            const Spacer(),
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: context.sizeConfig.width * 0.3),
              child: Text(
                date,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.fontSize16(context).copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            CustomSvgVisual(
              assetPath: Assets.assetsImagesCaptainIcon,
              width: context.setMinSize(30),
              height: context.setMinSize(30),
            ),
            context.setMinSize(20).horizontalSpace,
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: context.sizeConfig.width * 0.8),
              child: Text("Captain $name",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.fontSize16(context)
                      .copyWith(color: Colors.white)),
            )
          ],
        ),
        context.setMinSize(20).verticalSpace,
      ],
    );
  }
}
