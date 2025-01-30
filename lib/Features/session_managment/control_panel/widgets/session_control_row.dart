import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class SessionControlRow extends StatelessWidget {
  const SessionControlRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ControlPanelCubit>();
    return SizeConfig(
      baseSize: const Size(398, 90),
      width: context.setMinSize(398),
      height: context.setMinSize(90),
      child: Builder(builder: (context) {
        return Padding(
          padding: SizeConstants.kScaffoldPadding(context),
          child: SizedBox(
            width: context.sizeConfig.width,
            height: context.sizeConfig.height,
            child: Stack(
              children: [
                // Battery Indicator on the left
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizeConfig(
                    baseSize: const Size(90, 30),
                    width: context.setMinSize(90),
                    height: context.setMinSize(30),
                    child: Builder(builder: (context) {
                      return Container(
                        width: context.sizeConfig.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(context.setMinSize(10)),
                          color: AppColors.darkGreyColor,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: context.setMinSize(8),
                          vertical: context.setMinSize(5),
                        ),
                        child: Row(
                          children: [
                            CustomSvgVisual(
                              assetPath: Assets.assetsImagesBateryIcon,
                              width: context.setMinSize(20),
                              height: context.setMinSize(15),
                            ),
                            context.setMinSize(8).horizontalSpace,
                            Text(
                              "70%",
                              style: AppTextStyles.fontSize14(context)
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),

                // Centered Controls
                Container(
                  height: context.sizeConfig.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => cubit.decreaseAllMuscles(),
                        child: CustomSvgVisual(
                          assetPath: Assets.assetsImagesDecreaseIcon,
                          width: context.setMinSize(40),
                          height: context.setMinSize(40),
                        ),
                      ),
                      context.setMinSize(10).horizontalSpace,

                      // Start/Pause Button
                      BlocSelector<ControlPanelCubit, ControlPanelState, bool>(
                        selector: (state) => state.isRunning,
                        builder: (context, isRunning) {
                          return GestureDetector(
                            onTap: () => isRunning
                                ? cubit.pauseSession()
                                : cubit.startSession(),
                            child: CustomSvgVisual(
                              assetPath: isRunning
                                  ? Assets.assetsImagesPauseIcon
                                  : Assets.assetsImagesStartIcon,
                              width: context.setMinSize(70),
                              height: context.setMinSize(70),
                            ),
                          );
                        },
                      ),
                      context.setMinSize(10).horizontalSpace,

                      // Increase Button
                      GestureDetector(
                        onTap: () => cubit.increaseAllMuscles(),
                        child: CustomSvgVisual(
                          assetPath: Assets.assetsImagesIncreaseIcon,
                          width: context.setMinSize(40),
                          height: context.setMinSize(40),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
