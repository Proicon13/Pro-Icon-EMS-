import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/data/repos/session_control_panel_repo.dart';

import '../../../../../Core/dependencies.dart';
import '../../../../../Core/entities/control_panel_mad.dart';

part 'control_panel_state.dart';

class ControlPanelCubit extends Cubit<ControlPanelState> {
  final SessionManagementRepository sessionManagementRepository;
  ControlPanelCubit({required this.sessionManagementRepository})
      : super(const ControlPanelState());

  void fetchControlPanelMads() async {
    emit(state.copyWith(status: SessionStatus.intializing));
    final currentUserMads = getIt<UserStateCubit>().state.currentUser!.mads!;
    final result = await sessionManagementRepository.getControlPanelMads(
        rawMads: currentUserMads);
    result.fold(
      (failure) => emit(state.copyWith(status: SessionStatus.error)),
      (mads) => emit(state.copyWith(
        selectedMads: [mads[0]], //first mad is selected
        controlPanelMads: mads,
      )),
    );
  }
}
