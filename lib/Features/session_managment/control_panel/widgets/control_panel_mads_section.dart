import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/control_panel_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/utils/responsive_helper/size_constants.dart';

class ControlPanelMadsSection extends StatelessWidget {
  const ControlPanelMadsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ControlPanelCubit>();
    return BlocBuilder<ControlPanelCubit, ControlPanelState>(
      buildWhen: (previous, current) =>
          previous.controlPanelMads != current.controlPanelMads ||
          previous.status != current.status ||
          previous.selectedMads != current.selectedMads,
      builder: (context, state) {
        if (state.isInitializing) {
          // loading
          return _buildLoadingContent(context);
        }

        if (state.isReady) {
          // if list is loaded and no error
          return _buildLoadedContent(context, state, cubit);
        }
        // otherwise show nothing

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadedContent(
      BuildContext context, ControlPanelState state, ControlPanelCubit cubit) {
    return Column(
      children: [
        SizeConfig(
          baseSize: const Size(125, 140),
          width: context.setMinSize(125),
          height: context.setMinSize(140),
          child: Builder(builder: (context) {
            return SizedBox(
              height: context.sizeConfig.height,
              child: ListView.builder(
                padding: EdgeInsets.only(left: context.setMinSize(16)),
                itemCount: state.controlPanelMads.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final controlPanelMad = state.controlPanelMads[index];
                  return ControlPanelCard(
                      key: ValueKey(controlPanelMad.madNo),
                      mad: controlPanelMad,
                      isSelected: state.selectedMads!.contains(controlPanelMad),
                      onTap: () {
                        cubit.onControlPanelMadTap(controlPanelMad, index);
                      },
                      onLongPress: () {});
                },
              ),
            );
          }),
        ),
        context.setMinSize(10).verticalSpace,
        Padding(
          padding: SizeConstants.kScaffoldPadding(context),
          child: Divider(
            color: AppColors.lightGreyColor,
            thickness: context.setMinSize(1),
          ),
        )
      ],
    );
  }

  Skeletonizer _buildLoadingContent(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const PulseEffect(),
      child: SizeConfig(
        baseSize: const Size(95, 125),
        width: context.setMinSize(95),
        height: context.setMinSize(125),
        child: Builder(builder: (context) {
          return SizedBox(
            height: context.sizeConfig.height,
            child: ListView.builder(
              key: const ValueKey("control-panel-loading-list"),
              itemCount: 3,
              padding: EdgeInsets.only(left: context.setMinSize(16)),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: context.sizeConfig.width,
                  margin: EdgeInsets.only(
                    right: context.setMinSize(10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(context.setMinSize(20)),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
