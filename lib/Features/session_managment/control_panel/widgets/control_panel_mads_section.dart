import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/assign_client_dialog.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/bluetooth_devices_dialog.dart';
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
          previous.selectedMads != current.selectedMads ||
          previous.availableDevices != current.availableDevices,
      builder: (context, state) {
        if (state.isInitializing) {
          return _buildLoadingContent(context);
        }

        if (state.isError) {
          return const SizedBox.shrink();
        }
        return _buildLoadedContent(context, state, cubit);
      },
    );
  }

  Widget _buildLoadedContent(
      BuildContext ctx, ControlPanelState state, ControlPanelCubit cubit) {
    return Column(
      children: [
        SizeConfig(
          baseSize: const Size(125, 140),
          width: ctx.setMinSize(125),
          height: ctx.setMinSize(140),
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
                      if (controlPanelMad.client == null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AssignClientDialog(
                              onClientSelect: (client) {
                                Navigator.pop(context);
                                ctx
                                    .read<ControlPanelCubit>()
                                    .onClientMadAssign(client, index);
                              },
                            );
                          },
                        );
                      }
                    },
                    onLongPress: () {
                      // Show Bluetooth Dialog if MAD Device isnot connected**
                      if (controlPanelMad.madDevice == null) {
                        _showBluetoothDialog(ctx, cubit, isHeartRate: false);
                      }
                      // Show Bluetooth Dialog if Heart Rate Sensor is not connected
                      else if (controlPanelMad.heartRateDevice == null) {
                        _showBluetoothDialog(ctx, cubit, isHeartRate: true);
                      }
                    },
                  );
                },
              ),
            );
          }),
        ),
        ctx.setMinSize(10).verticalSpace,
        Padding(
          padding: SizeConstants.kScaffoldPadding(ctx),
          child: Divider(
            color: AppColors.lightGreyColor,
            thickness: ctx.setMinSize(1),
          ),
        )
      ],
    );
  }

  /// **🔍 Show Bluetooth Devices Dialog**
  void _showBluetoothDialog(BuildContext context, ControlPanelCubit cubit,
      {required bool isHeartRate}) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: cubit..scanForDevices(),
          child: BluetoothDevicesDialog(
            availableDevices: cubit.state.availableDevices,
            isHeartRate: isHeartRate,
            onDeviceSelected: (device) {
              Navigator.pop(context);
              cubit.connectToDevice(device, isHeartRate);
            },
          ),
        );
      },
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
