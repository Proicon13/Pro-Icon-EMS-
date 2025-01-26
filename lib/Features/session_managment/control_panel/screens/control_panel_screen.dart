import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:pro_icon/Features/session_managment/session_setup/cubits/cubit/session_setup_state.dart';

import '../../../../Core/entities/automatic_session_entity.dart';
import '../../../../Core/entities/program_entity.dart';
import '../widgets/control_panel_screen_body.dart';

class ControlPanelScreen extends StatelessWidget {
  static const routeName = '/control-panel-screen';
  final SessionControlMode mode;
  final ProgramEntity? program;
  final AutomaticSessionEntity? session;
  final List<ProgramEntity>? programs;
  const ControlPanelScreen(
      {super.key,
      required this.mode,
      this.program,
      this.session,
      this.programs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ControlPanelCubit>(
      create: (context) => getIt<ControlPanelCubit>()
        ..onInit(
            mode: mode,
            program: program,
            automaticSession: session,
            allPrograms: programs)
        ..fetchControlPanelMads(),
      child: const BaseAppScaffold(
        body: ControlPanelScreenBody(),
      ),
    );
  }
}
