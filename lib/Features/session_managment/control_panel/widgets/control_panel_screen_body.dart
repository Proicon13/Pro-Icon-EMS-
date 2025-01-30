import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/muscles_control_section.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/timers_control_section.dart';

import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/utils/responsive_helper/size_constants.dart';
import '../cubits/cubit/control_panel_cubit.dart';
import 'control_panel_header.dart';
import 'control_panel_mads_section.dart';
import 'program_info_section.dart';
import 'session_control_row.dart';

class ControlPanelScreenBody extends StatelessWidget {
  const ControlPanelScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ControlPanelCubit, ControlPanelState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.isNotReady) {
          buildCustomAlert(context, state.errorMessage!, Colors.red);
          context.read<ControlPanelCubit>().pauseSession();
        }
        if (state.isError) {
          buildCustomAlert(context, state.errorMessage!, Colors.red);
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: context.setMinSize(15).verticalSpace,
          ),
          const SliverToBoxAdapter(
            child: ControlPanelHeader(),
          ),
          SliverToBoxAdapter(
            child: context.setMinSize(15).verticalSpace,
          ),
          const SliverToBoxAdapter(
            child: ControlPanelMadsSection(),
          ),
          const SliverToBoxAdapter(
            child: TimersControlSection(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                context.setMinSize(5).verticalSpace,
                Padding(
                  padding: SizeConstants.kScaffoldPadding(context),
                  child: Divider(
                    color: AppColors.lightGreyColor,
                    thickness: context.setMinSize(1),
                  ),
                ),
                context.setMinSize(5).verticalSpace
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: ProgramInfoSection(),
          ),
          const SliverToBoxAdapter(
            child: MusclesControlSection(),
          ),
          const SliverToBoxAdapter(
            child: SessionControlRow(),
          )
        ],
      ),
    );
  }
}
