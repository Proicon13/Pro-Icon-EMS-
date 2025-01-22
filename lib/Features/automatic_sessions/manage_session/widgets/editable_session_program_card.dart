import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/widgets/custom_rectaungular_image.dart';
import '../../../../data/models/auto_session_model.dart';

class EditableSessionProgramCard extends StatelessWidget {
  final SessionProgram sessionProgram;
  final VoidCallback onRemove;
  final VoidCallback onDurationIncrease;
  final VoidCallback onDurationDecrease;
  final VoidCallback onPulseIncrease;
  final VoidCallback onPulseDecrease;

  const EditableSessionProgramCard({
    super.key,
    required this.sessionProgram,
    required this.onRemove,
    required this.onDurationIncrease,
    required this.onDurationDecrease,
    required this.onPulseIncrease,
    required this.onPulseDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sizeConfig.width,
      height: context.sizeConfig.height,
      margin: EdgeInsets.only(bottom: context.setMinSize(15)),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(context.setMinSize(8)),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(context.setMinSize(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image
              CustomRectangularImage(
                width: context.sizeConfig.height * 0.7,
                height: context.sizeConfig.height * 0.7,
                imageUrl: sessionProgram.program?.image ?? '',
              ),
              context.setMinSize(10).horizontalSpace,

              // Details Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Program Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            sessionProgram.program?.name ?? "Program Name",
                            style: AppTextStyles.fontSize16(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: onRemove,
                          child: CustomSvgVisual(
                            assetPath: Assets.assetsImagesCloseIcon,
                            width: context.setMinSize(24),
                            height: context.setMinSize(24),
                          ),
                        ),
                      ],
                    ),
                    context.setMinSize(8).verticalSpace,

                    // Duration Counter
                    Row(
                      children: [
                        Row(
                          children: [
                            CustomSvgVisual(
                                assetPath: Assets.assetsImagesDurationIcon,
                                width: context.setMinSize(24),
                                height: context.setMinSize(24)),
                            context.setMinSize(15).horizontalSpace,
                            CounterRow(
                              count: sessionProgram.duration ?? 0,
                              onIncrement: onDurationIncrease,
                              onDecrement: onDurationDecrease,
                            ),
                          ],
                        ),
                        context.setMinSize(20).horizontalSpace,
                        Row(
                          children: [
                            Icon(Icons.bolt,
                                color: AppColors.primaryColor,
                                size: context.setMinSize(24)),
                            context.setMinSize(8).horizontalSpace,
                            CounterRow(
                              count: sessionProgram.pulse ?? 0,
                              onIncrement: onPulseIncrease,
                              onDecrement: onPulseDecrease,
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Pulse Counter
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterRow extends StatelessWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterRow({
    Key? key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Decrement Button
        GestureDetector(
          onTap: onDecrement,
          child: Container(
            width: context.setMinSize(28),
            height: context.setMinSize(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.setMinSize(8)),
            ),
            child: Icon(
              Icons.remove,
              size: context.setMinSize(14),
              color: Colors.black,
            ),
          ),
        ),
        context.setMinSize(10).horizontalSpace,

        // Count Display
        Text(
          count.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: context.setMinSize(14),
          ),
        ),
        context.setMinSize(10).horizontalSpace,

        // Increment Button
        GestureDetector(
          onTap: onIncrement,
          child: Container(
            width: context.setMinSize(28),
            height: context.setMinSize(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(context.setMinSize(8)),
            ),
            child: Icon(
              Icons.add,
              size: context.setMinSize(14),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
