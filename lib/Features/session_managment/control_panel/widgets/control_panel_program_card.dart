import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/entities/program_entity.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_rectaungular_image.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class ControlPanelProgramCard extends StatelessWidget {
  final ProgramEntity program;
  final void Function()? onTap;

  const ControlPanelProgramCard({
    super.key,
    required this.program,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: context.sizeConfig.width,
        height: context.sizeConfig.height,
        child: Column(
          children: [
            CustomRectangularImage(
              width: context.sizeConfig.width * 0.7,
              height: context.sizeConfig.height * 0.55,
              imageUrl: program.image,
            ),
            context.setMinSize(7).verticalSpace,
            SizedBox(
              width: context.sizeConfig.width,
              child: Text(
                program.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.fontSize14(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            context.setMinSize(3).verticalSpace,

            // Ensuring full width usage for HZ and PU row
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.sizeConfig.width),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Keeps both sides spaced properly
                children: [
                  // HZ Text (Flexible to handle overflow)
                  Flexible(
                    child: Text(
                      "HZ ${program.hertez}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.fontSize12(context).copyWith(
                        color: AppColors.white71Color,
                      ),
                    ),
                  ),

                  context.setMinSize(4).horizontalSpace,

                  // Pulse Icon
                  CustomSvgVisual(
                    assetPath: Assets.assetsImagesPulseIcon,
                    width: context.setMinSize(12),
                    height: context.setMinSize(12),
                  ),

                  context.setMinSize(4).horizontalSpace,

                  // PU Text (Flexible to handle overflow)
                  Flexible(
                    child: Text(
                      "PU ${program.pulse}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.fontSize12(context).copyWith(
                        color: AppColors.white71Color,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
