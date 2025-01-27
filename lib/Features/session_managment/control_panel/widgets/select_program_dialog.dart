import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/entities/program_entity.dart';
import '../../../../Core/widgets/custom_rectaungular_image.dart';

class ProgramCard extends StatelessWidget {
  final ProgramEntity program;

  const ProgramCard({
    required this.program,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sizeConfig.width,
      height: context.sizeConfig.height,
      margin: EdgeInsets.symmetric(vertical: context.setMinSize(5)),
      padding: EdgeInsets.symmetric(
        vertical: context.setMinSize(10),
        horizontal: context.setMinSize(10),
      ),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(context.setMinSize(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomRectangularImage(
                imageUrl: program.image,
                width: context.setMinSize(60),
                height: context.setMinSize(60),
              ),
              context.setMinSize(10).horizontalSpace,
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.sizeConfig.width * 0.3,
                ),
                child: Text(
                  program.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.fontSize16(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.sizeConfig.width * 0.35,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "HZ ${program.hertez}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.fontSize14(context).copyWith(
                    color: AppColors.white71Color,
                  ),
                ),
                context.setMinSize(4).horizontalSpace,
                CustomSvgVisual(
                  assetPath: Assets.assetsImagesPulseIcon,
                  width: context.setMinSize(12),
                  height: context.setMinSize(12),
                ),
                context.setMinSize(4).horizontalSpace,
                Text(
                  "PU ${program.pulse}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.fontSize14(context).copyWith(
                    color: AppColors.white71Color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectProgramDialog extends StatelessWidget {
  final List<ProgramEntity> programs;
  final Function(ProgramEntity) onProgramSelected;

  const SelectProgramDialog({
    required this.programs,
    required this.onProgramSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 2,
      insetAnimationCurve: Curves.bounceInOut,
      insetAnimationDuration: const Duration(milliseconds: 400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(16)),
      ),
      backgroundColor: AppColors.backgroundColor,
      child: Container(
        height: context.screenHeight * 0.65,
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(16),
        ),
        child: Column(
          children: [
            context.setMinSize(20).verticalSpace,
            Text(
              "Select Program",
              style: AppTextStyles.fontSize20(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            context.setMinSize(20).verticalSpace,
            Expanded(
              child: ListView.builder(
                itemCount: programs.length,
                padding: EdgeInsets.symmetric(
                  horizontal: context.setMinSize(5),
                ),
                itemBuilder: (context, index) {
                  final program = programs[index];
                  return GestureDetector(
                    onTap: () => onProgramSelected(program),
                    child: SizeConfig(
                      baseSize: const Size(400, 80),
                      width: context.setMinSize(400),
                      height: context.setMinSize(80),
                      child: Builder(builder: (context) {
                        return ProgramCard(
                          program: program,
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
