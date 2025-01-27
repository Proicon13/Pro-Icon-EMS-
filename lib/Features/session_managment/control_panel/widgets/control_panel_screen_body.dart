import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/muscles_control_section.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/program_info_section.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/timers_control_section.dart';

import '../cubits/cubit/control_panel_cubit.dart';
import 'control_panel_header.dart';
import 'control_panel_mads_section.dart';

class ControlPanelScreenBody extends StatelessWidget {
  const ControlPanelScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ControlPanelCubit, ControlPanelState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
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
          const SliverToBoxAdapter(
            child: ProgramInfoSection(),
          ),
          const SliverToBoxAdapter(
            child: MusclesControlSection(),
          )
        ],
      ),
    );
  }
}
