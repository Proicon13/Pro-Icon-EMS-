import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_asset_image.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/utils/responsive_helper/size_constants.dart';
import 'muscle_column.dart';

class MusclesControlSection extends StatelessWidget {
  const MusclesControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlPanelCubit, ControlPanelState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.isError) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: SizeConstants.kScaffoldPadding(context),
          child: Skeletonizer(
            enabled: state.isInitializing,
            child: Column(
              children: [
                context.setMinSize(10).verticalSpace,
                BlocSelector<ControlPanelCubit, ControlPanelState,
                    Map<String, int>>(
                  selector: (state) {
                    return state.selectedMads!.isNotEmpty
                        ? state.selectedMads!.first.musclesPercentage
                        : {"loading-1": 0, "loading-2": 0, "loading-3": 0};
                  },
                  builder: (context, musclesMap) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: MuscleColumn(
                            muscleEntries: musclesMap.entries
                                .where((entry) =>
                                    musclesMap.entries.toList().indexOf(entry) %
                                        2 ==
                                    0)
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          width: context.setMinSize(120),
                          height: context.setMinSize(200),
                          child: const CustomAssetImage(
                            path: Assets.assetsImagesBodyImage,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: MuscleColumn(
                            muscleEntries: musclesMap.entries
                                .where((entry) =>
                                    musclesMap.entries.toList().indexOf(entry) %
                                        2 !=
                                    0)
                                .toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
