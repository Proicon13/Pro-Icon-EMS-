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
    if (state.isGroupMode) return; // ignore if group mode
    final mads = [...state.controlPanelMads];
    if (mad.client == null) {
      mads[index] = mads[index].copyWith(
          heartRate: 80,
          isBluetoothConnected: true,
          isHeartRateSensorConnected: true,
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

  void onControlChanged(String key, num value) {
    switch (key) {
      case 'On':
        adjustOnTime(value);
        break;
      case 'Off':
        adjustOffTime(value);
        break;
      case 'Ramp':
        adjustRamp(value);
        break;
    }
  }

  void adjustOnTime(num value) {
    if (value < 0) {
      return;
    }
    emit(state.copyWith(onTime: value.toInt()));
  }

  void adjustOffTime(num value) {
    if (value < 0) {
      return;
    }
    emit(state.copyWith(offTime: value.toInt()));
  }

  void adjustRamp(num value) {
    if (value < 0) {
      return;
    }
    emit(state.copyWith(ramp: value.toDouble()));
  }

  /// Adjusts a specific muscle value for the first selected Mad
  void adjustMuscleValue(String muscleKey, bool isIncrement) {
    final updatedMuscles = _validateAndFetchMuscles();
    if (updatedMuscles == null) return;

    if (!updatedMuscles.containsKey(muscleKey)) {
      emit(state.copyWith(
          status: SessionStatus.error,
          errorMessage: "Invalid muscle selection."));
      return;
    }

    // Adjust value with prevention for negative numbers
    final int newValue = isIncrement
        ? updatedMuscles[muscleKey]! + 1
        : (updatedMuscles[muscleKey]! - 1).clamp(0, double.infinity).toInt();
    updatedMuscles[muscleKey] = newValue;

    _updateSelectedMad(updatedMuscles);
  }

  /// Increases all muscle values for the first selected Mad
  void increaseAllMuscles() {
    final updatedMuscles = _validateAndFetchMuscles();
    if (updatedMuscles == null) return;

    updatedMuscles.updateAll((key, value) => value + 1);
    _updateSelectedMad(updatedMuscles);
  }

  /// Decreases all muscle values for the first selected Mad
  void decreaseAllMuscles() {
    final updatedMuscles = _validateAndFetchMuscles();
    if (updatedMuscles == null) return;

    updatedMuscles.updateAll(
        (key, value) => (value - 1).clamp(0, double.infinity).toInt());
    _updateSelectedMad(updatedMuscles);
  }

  /// ✅ **Extracted Function: Validates & Fetches Muscle Map**
  Map<String, int>? _validateAndFetchMuscles() {
    if (state.selectedMads!.isEmpty) return null;

    final selectedMad = state.selectedMads!.first;

    // Ensure the Mad has a client assigned
    if (selectedMad.client == null) {
      emit(state.copyWith(
          status: SessionStatus.notReady,
          errorMessage: "Client not assigned."));
      return null;
    }

    // Ensure Bluetooth and Heart Rate sensors are connected
    if (!selectedMad.isBluetoothConnected! ||
        !selectedMad.isHeartRateSensorConnected!) {
      emit(state.copyWith(
          status: SessionStatus.notReady,
          errorMessage:
              "Ensure Bluetooth and Heart Rate sensors are connected."));
      return null;
    }

    return Map<String, int>.from(selectedMad.musclesPercentage);
  }

  void _updateSelectedMad(Map<String, int> updatedMuscles) {
    final updatedMad =
        state.selectedMads!.first.copyWith(musclesPercentage: updatedMuscles);
    final updatedMads = [...state.selectedMads!];
    updatedMads[0] = updatedMad;

    final updatedControlPanelMads = state.controlPanelMads.map((mad) {
      return mad.madNo == updatedMad.madNo ? updatedMad : mad;
    }).toList();

    emit(state.copyWith(
        selectedMads: updatedMads, controlPanelMads: updatedControlPanelMads));
  }

  void onGroupModeToggle(bool isGroupMode) {
    if (state.controlPanelMads.isEmpty) return;

    emit(state.copyWith(
      isGroupMode: isGroupMode,
      selectedMads:
          isGroupMode ? state.controlPanelMads : [state.controlPanelMads.first],
    ));
  }
}
