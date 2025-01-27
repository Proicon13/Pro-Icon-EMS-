import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/entities/client_entity.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Features/session_managment/session_setup/cubits/cubit/session_setup_state.dart';
import 'package:pro_icon/data/models/auto_session_model.dart';
import 'package:pro_icon/data/repos/session_control_panel_repo.dart';

import '../../../../../Core/dependencies.dart';
import '../../../../../Core/entities/automatic_session_entity.dart';
import '../../../../../Core/entities/control_panel_mad.dart';

part 'control_panel_state.dart';

class ControlPanelCubit extends Cubit<ControlPanelState> {
  final SessionManagementRepository sessionManagementRepository;
  ControlPanelCubit({required this.sessionManagementRepository})
      : super(const ControlPanelState());

  void onInit(
      {required SessionControlMode mode,
      ProgramEntity? program,
      AutomaticSessionEntity? automaticSession,
      List<ProgramEntity>? allPrograms}) {
    // intializing session
    try {
      emit(state.copyWith(status: SessionStatus.intializing));
      setSessionMode(mode);
      if (mode == SessionControlMode.program) {
        // if mode is program set current program and all programs available
        setCurrentProgram(program!);
        setAllPrograms(allPrograms!);
      } else if (mode == SessionControlMode.auto) {
        // if mode is auto set automatic session programs
        setAutomaticSessionPrograms(automaticSession!.sessionPrograms!);
      }
    } catch (_) {
      emit(state.copyWith(
          status: SessionStatus.error,
          errorMessage: "failed to fetch session mode and data"));
    }
  }

  void setSessionMode(SessionControlMode sessionControlMode) {
    emit(state.copyWith(selectedSessionMode: sessionControlMode));
  }

  void setCurrentProgram(ProgramEntity program) {
    emit(state.copyWith(selectedProgram: program));
  }

  void setAutomaticSessionPrograms(List<SessionProgram> programs) {
    emit(state.copyWith(automaticSessionprograms: programs));
  }

  void setAllPrograms(List<ProgramEntity> programs) {
    emit(state.copyWith(allPrograms: programs));
  }

  void onControlPanelMadTap(ControlPanelMad mad, int index) {
    final mads = [...state.controlPanelMads];
    if (mad.client == null) {
      mads[index] = mads[index].copyWith(
          client: const ClientEntity(id: 0, fullname: 'Moaid Mohamed'));
    }
    emit(state.copyWith(selectedMads: [mads[index]], controlPanelMads: mads));
  }

  void fetchControlPanelMads() async {
    final currentUserMads = getIt<UserStateCubit>().state.currentUser!.mads!;
    final result = await sessionManagementRepository.getControlPanelMads(
        rawMads: currentUserMads);
    result.fold(
      (failure) => emit(state.copyWith(
          status: SessionStatus.error, errorMessage: failure.message)),
      (mads) {
        if (mads.isEmpty) {
          return emit(state.copyWith(
              status: SessionStatus.error,
              errorMessage: "No mads found to start session"));
        }
        emit(state.copyWith(
            selectedMads: [mads[0]], //first mad is selected
            controlPanelMads: mads,
            status: SessionStatus.ready,
            errorMessage: ""));
      },
    );
  }
}
