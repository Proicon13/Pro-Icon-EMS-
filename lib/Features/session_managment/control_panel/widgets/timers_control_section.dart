import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/theme/app_colors.dart';
import 'timer_card.dart';
import 'timers_control_panel.dart';

class TimersControlSection extends StatelessWidget {
  const TimersControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlPanelCubit, ControlPanelState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.isError) {
          return const SizedBox.shrink();
        }
        return Skeletonizer(
          enabled: state.isInitializing,
          child: Padding(
            padding: SizeConstants.kScaffoldPadding(context),
            child: Column(
              children: [
                context.setMinSize(10).verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TimerCard(
                      size: context.setMinSize(70),
                      isRed: false,
                      value: "8",
                      textStyle: AppTextStyles.fontSize16(context).copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                      currentValue: 9,
                      fullValue: 10,
                    ),
                    const Spacer(),
                    TimerCard(
                      size: context.setMinSize(120),
                      isRed: true,
                      value: "04:40",
                      textStyle: AppTextStyles.fontSize20(context).copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      currentValue: 8,
                      fullValue: 10,
                    ),
                    context.setMinSize(20).horizontalSpace,
                    TimersControlPanel(
                      onChanged: (key, value) {
                        // Implement changes to timer values here
                        context
                            .read<ControlPanelCubit>()
                            .onControlChanged(key, value);
                      },
                    ),
                  ],
                ),
                context.setMinSize(10).verticalSpace,
                Divider(
                  color: AppColors.white71Color,
                  thickness: context.setMinSize(1),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
