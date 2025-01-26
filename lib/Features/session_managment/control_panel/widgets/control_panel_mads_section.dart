import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/control_panel_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ControlPanelMadsSection extends StatelessWidget {
  const ControlPanelMadsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlPanelCubit, ControlPanelState>(
      buildWhen: (previous, current) =>
          previous.controlPanelMads != current.controlPanelMads ||
          previous.status != current.status ||
          previous.selectedMads != current.selectedMads,
      builder: (context, state) {
        if (state.controlPanelMads.isEmpty &&
            state.status != SessionStatus.error) {
          // if list is empty and no error so loading
          return _buildLoadingContent(context);
        }
        if (state.controlPanelMads.isNotEmpty &&
            state.status != SessionStatus.error) {
          // if list is loaded and no error
          return _buildLoadedContent(context, state);
        }
        // otherwise show nothing

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadedContent(BuildContext context, ControlPanelState state) {
    return SizeConfig(
      baseSize: const Size(95, 125),
      width: context.setMinSize(95),
      height: context.setMinSize(125),
      child: Builder(builder: (context) {
        return SizedBox(
          height: context.sizeConfig.height,
          child: ListView.builder(
            itemCount: state.controlPanelMads.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final controlPanelMad = state.controlPanelMads[index];
              ControlPanelCard(
                  mad: controlPanelMad,
                  isSelected: state.selectedMads!.contains(controlPanelMad),
                  onTap: () {},
                  onLongPress: () {});
              return null;
            },
          ),
        );
      }),
    );
  }

  Skeletonizer _buildLoadingContent(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizeConfig(
        baseSize: const Size(95, 125),
        width: context.setMinSize(95),
        height: context.setMinSize(125),
        child: Builder(builder: (context) {
          return SizedBox(
            height: context.sizeConfig.height,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: context.sizeConfig.width,
                  margin: EdgeInsets.only(
                    right: context.setMinSize(10),
                  ),
                  decoration: BoxDecoration(
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
