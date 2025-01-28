import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/session_control_row.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/utils/responsive_helper/size_constants.dart';
import 'muscles_view_grid.dart';

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
                    return SizeConfig(
                      baseSize: const Size(400, 290),
                      width: context.setMinSize(400),
                      height: context.setMinSize(290),
                      child: Builder(builder: (context) {
                        return MusclesValueGrid(
                          musclesMap: musclesMap,
                        );
                      }),
                    );
                  },
                ),
                const SessionControlRow(),
              ],
            ),
          ),
        );
      },
    );
  }
}
