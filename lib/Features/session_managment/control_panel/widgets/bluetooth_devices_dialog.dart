import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_loader.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';

class BluetoothDevicesDialog extends StatelessWidget {
  final bool isHeartRate;
  final List<BluetoothDevice> availableDevices;
  final Function(BluetoothDevice) onDeviceSelected;

  const BluetoothDevicesDialog({
    super.key,
    required this.isHeartRate,
    required this.availableDevices,
    required this.onDeviceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(16)),
      ),
      backgroundColor: AppColors.backgroundColor,
      child: SizedBox(
        height: context.sizeConfig.height * 0.5,
        child: Padding(
          padding: SizeConstants.kScaffoldPadding(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              context.setMinSize(30).verticalSpace,

              // **Dialog Title**
              Text(
                isHeartRate ? "Select Heart Rate Sensor" : "Select MAD Device",
                style: AppTextStyles.fontSize20(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              context.setMinSize(16).verticalSpace,

              // **List of Devices**
              BlocBuilder<ControlPanelCubit, ControlPanelState>(
                buildWhen: (previous, current) =>
                    previous.availableDevices != current.availableDevices ||
                    previous.isScanning != current.isScanning,
                builder: (context, state) {
                  if (state.isScanning) {
                    return const Expanded(child: CustomLoader());
                  }
                  return Expanded(
                    child: availableDevices.isEmpty
                        ? Center(
                            child: Text(
                              "No devices found.",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.fontSize16(context)
                                  .copyWith(color: Colors.white),
                            ),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                              color: AppColors.white71Color,
                              thickness: 1,
                              height: context.setMinSize(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: context.setMinSize(10)),
                            itemCount: availableDevices.length,
                            itemBuilder: (context, index) {
                              final device = availableDevices[index];

                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  Icons.bluetooth,
                                  size: context.setMinSize(30),
                                  color: isHeartRate
                                      ? Colors.redAccent
                                      : Colors.blueAccent,
                                ),
                                title: Column(
                                  children: [
                                    Text(
                                      device.platformName.isNotEmpty
                                          ? device.platformName
                                          : "Unknown Device",
                                      style: AppTextStyles.fontSize18(context)
                                          .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    context.setMinSize(5).verticalSpace,
                                    Text(
                                      device.servicesList.length.toString(),
                                      style: AppTextStyles.fontSize18(context)
                                          .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  onDeviceSelected(device);
                                },
                              );
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
