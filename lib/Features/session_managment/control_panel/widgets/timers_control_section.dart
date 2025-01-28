import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/utils/format_duration.dart';
import 'timer_card.dart';
import 'timers_control_panel.dart';

class TimersControlSection extends StatelessWidget {
  const TimersControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlPanelCubit, ControlPanelState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final totalDuration = state.totalDuration;
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
                    // On/Off Timer
                    BlocBuilder<ControlPanelCubit, ControlPanelState>(
                      buildWhen: (previous, current) =>
                          previous.isOnCycle != current.isOnCycle ||
                          previous.onTime != current.onTime ||
                          previous.offTime != current.offTime ||
                          previous.currentOnTime != current.currentOnTime ||
                          previous.currentOffTime != current.currentOffTime,
                      builder: (context, state) {
                        final isOnCycle = state.isOnCycle;
                        final currentCycleValue = isOnCycle
                            ? state.currentOnTime
                            : state.currentOffTime;
                        final fullCycleValue =
                            isOnCycle ? state.onTime : state.offTime;

                        return TimerCard(
                          size: context.setMinSize(70),
                          isRed: !isOnCycle,
                          value: currentCycleValue.toString(),
                          textStyle: AppTextStyles.fontSize16(context).copyWith(
                            color: isOnCycle ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          currentValue: currentCycleValue,
                          fullValue: fullCycleValue == 0
                              ? 1
                              : fullCycleValue, // Avoid division by 0
                        );
                      },
                    ),

                    const Spacer(),

                    // Session Duration Timer
                    BlocSelector<ControlPanelCubit, ControlPanelState,
                        Duration>(
                      selector: (state) => state.currentDuration,
                      builder: (context, currentDuration) {
                        return TimerCard(
                          size: context.setMinSize(120),
                          isRed: false,
                          value: formatDuration(currentDuration),
                          textStyle: AppTextStyles.fontSize24(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          currentValue: currentDuration.inSeconds,
                          fullValue: totalDuration.inSeconds,
                        );
                      },
                    ),
                    context.setMinSize(20).horizontalSpace,

                    // Timers Control Panel
                    TimersControlPanel(
                      onChanged: (key, value) {
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
