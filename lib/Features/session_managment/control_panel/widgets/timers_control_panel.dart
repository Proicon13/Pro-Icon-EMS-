import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';

import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/counter_row.dart';

class TimersControlPanel extends StatelessWidget {
  final Function(String, num) onChanged;

  const TimersControlPanel({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      baseSize: const Size(180, 115),
      width: context.setMinSize(180),
      height: context.setMinSize(115),
      child: Builder(builder: (context) {
        return Container(
          width: context.sizeConfig.width,
          height: context.sizeConfig.height,
          padding: EdgeInsets.all(context.setMinSize(5)),
          decoration: BoxDecoration(
            color: AppColors.darkGreyColor,
            borderRadius: BorderRadius.circular(context.setMinSize(10)),
            border: Border.all(
                color: AppColors.white71Color, width: context.setMinSize(1.5)),
          ),
          child: Column(
            children: [
              BlocSelector<ControlPanelCubit, ControlPanelState, int>(
                selector: (state) {
                  return state.onTime;
                },
                builder: (context, onTime) {
                  return _buildControlRow(
                    context,
                    "On",
                    onTime,
                    Colors.green,
                  );
                },
              ),
              _buildDivider(context),
              BlocSelector<ControlPanelCubit, ControlPanelState, int>(
                selector: (state) {
                  return state.offTime;
                },
                builder: (context, offTime) {
                  return _buildControlRow(
                    context,
                    "Off",
                    offTime,
                    AppColors.primaryColor,
                  );
                },
              ),
              _buildDivider(context),
              BlocSelector<ControlPanelCubit, ControlPanelState, double>(
                selector: (state) {
                  return state.ramp;
                },
                builder: (context, ramp) {
                  return _buildControlRow(
                    context,
                    "Ramp",
                    ramp,
                    Colors.white,
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildControlRow(
      BuildContext context, String label, num value, Color color) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                label == "On"
                    ? Icons.toggle_on_outlined
                    : label == "Off"
                        ? Icons.toggle_off_outlined
                        : Icons.bar_chart,
                color: color,
                size: context.setMinSize(24),
              ),
              context.setMinSize(8).horizontalSpace,
              Text(
                label,
                style: AppTextStyles.fontSize14(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          CounterRow(
            count: value,
            size: context.setMinSize(21),
            onIncrement: () =>
                onChanged(label, label == "Ramp" ? value + 0.1 : value + 1),
            onDecrement: () =>
                onChanged(label, label == "Ramp" ? value - 0.1 : value - 1),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return SizedBox(
      width: context.sizeConfig.width,
      height: context.setMinSize(2),
      child: Container(
        color: AppColors.white71Color,
      ),
    );
  }
}
