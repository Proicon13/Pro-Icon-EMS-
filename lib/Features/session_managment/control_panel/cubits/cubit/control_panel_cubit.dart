import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/entities/client_entity.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Features/session_managment/session_setup/cubits/cubit/session_setup_state.dart';
import 'package:pro_icon/data/models/auto_session_model.dart';
import 'package:pro_icon/data/repos/session_control_panel_repo.dart';

import '../../../../../Core/dependencies.dart';
import '../../../../../Core/entities/automatic_session_entity.dart';
import '../../../../../Core/entities/control_panel_mad.dart';
import '../../../../../Core/entities/mad_bluetooth_model.dart';
import '../../../../../Core/entities/user_entity.dart';

part 'control_panel_state.dart';

class ControlPanelCubit extends Cubit<ControlPanelState> {
  final SessionManagementRepository sessionManagementRepository;
  ControlPanelCubit({required this.sessionManagementRepository})
      : super(const ControlPanelState());

  Timer? _sessionTimer;
  Timer? _onOffTimer;
  Timer? _programTimer;

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
        setSessionDuration(Duration(minutes: automaticSession!.duration!));
        setAutomaticSessionPrograms(automaticSession.sessionPrograms!);
      }
    } catch (_) {
      emit(state.copyWith(
          status: SessionStatus.error,
          errorMessage: "failed to fetch session mode and data"));
    }
  }

  void scanForDevices() async {
    emit(state.copyWith(isScanning: true));
    final scanResponse = await sessionManagementRepository.scanForDevices();
    scanResponse.fold((_) {
      emit(state.copyWith(isScanning: false));
    }, (devices) {
      emit(state.copyWith(availableDevices: devices, isScanning: false));
    });
  }

  Future<void> listenToHeartRate(ControlPanelMad mad) async {
    if (mad.heartRateDevice == null) return;

    final result =
        await sessionManagementRepository.listenToHeartRate(mad: mad);

    result.fold(
      (failure) {
        emit(state.copyWith(
            status: SessionStatus.notReady, errorMessage: failure.message));
      },
      (updatedMad) {
        // ✅ Update MADs list with new heart rate data
        final updatedMads = state.controlPanelMads
            .map((m) => m.madNo == updatedMad.madNo ? updatedMad : m)
            .toList();

        final updatedSelectedMads = state.selectedMads!.map((m) {
          return m.madNo == updatedMad.madNo ? updatedMad : m;
        }).toList();

        emit(state.copyWith(
          controlPanelMads: updatedMads,
          selectedMads: updatedSelectedMads,
        ));
      },
    );
  }

  Future<void> connectToDevice(
      BluetoothDevice device, bool isHeartRateDevice) async {
    if (state.controlPanelMads.isEmpty) return;

    final mad = state.selectedMads!.isNotEmpty
        ? state.selectedMads!.first
        : state.controlPanelMads.first;

    final result = await sessionManagementRepository.connectToDevice(
        mad, device, isHeartRateDevice);

    result.fold(
      (failure) {
        emit(state.copyWith(
            status: SessionStatus.notReady, errorMessage: failure.message));
      },
      (updatedMad) {
        // update selected mads
        final updatedMads = state.controlPanelMads
            .map((m) => m.madNo == updatedMad.madNo ? updatedMad : m)
            .toList();
        emit(state.copyWith(
          controlPanelMads: updatedMads,
          selectedMads: [updatedMad],
        ));
      },
    );
  }

  Future<void> disconnectFromDevice(
      ControlPanelMad mad, BluetoothDevice device, bool isHeartRate) async {
    final result = await sessionManagementRepository.disconnectFromDevice(
        mad, device, isHeartRate);

    result.fold(
      (failure) {
        emit(state.copyWith(
            status: SessionStatus.notReady, errorMessage: failure.message));
      },
      (_) {
        // Update MAD state to reflect the disconnection
        final updatedMads = state.controlPanelMads.map((mad) {
          if (mad.madDevice == device || mad.heartRateDevice == device) {
            return mad.updateBluetoothStatus(
                madConnected: false, heartRateConnected: false);
          }
          return mad;
        }).toList();

        emit(state.copyWith(controlPanelMads: updatedMads));
      },
    );
  }

  Future<void> sendDataToAllMads({bool isStopSignal = false}) async {
    // get all mads that are connected and have heart rate
    final mads = List<ControlPanelMad>.from(state.selectedMads!)
        .where((mad) =>
            mad.isBluetoothConnected! && mad.isHeartRateSensorConnected!)
        .toList();
    if (mads.isEmpty) return;
    for (var mad in mads) {
      if (isStopSignal) {
        sendStopSignal(mad);
      } else {
        sendDataToMad(mad);
      }
    }
  }

  void sendStopSignal(ControlPanelMad mad) async {
    final stopSignal = MadBluetoothModel.formatStopSignal();

    final result = await sessionManagementRepository.sendDataToBluetooth1(
        device: mad.madDevice!, data: stopSignal);
    result.fold((failure) {
      emit(state.copyWith(
          status: SessionStatus.notReady,
          errorMessage: "failed to stop signal"));
    }, (_) {});
  }

  Future<void> sendDataToMad(ControlPanelMad mad) async {
    if (mad.madDevice == null) return;
    if (state.selectedProgram == null) return;

    final pulseWidthValues = _getPulseWidthValues();

    final onTime = state.onTime;
    final offTime = state.offTime;
    final ramp = int.parse(state.ramp.toString());
    final muscles = mad.musclesPercentage.values.toList();

    final frequency = state.selectedProgram!.hertez;

    // ✅ Create `MadBluetoothModel` Object
    final madBluetoothData = MadBluetoothModel(
      onTime: onTime,
      offTime: offTime,
      ramp: int.parse(ramp.toString()),
      pulseWidthValues: pulseWidthValues,
      muscleValues: muscles,
      frequency: frequency,
    );

    // ✅ Send data to BL1 (Muscles & Pulse)
    // final bl1Data = madBluetoothData.formatDataForCharacteristic1();
    final bl1Data = madBluetoothData.formatDataForCharacteristic1();
    final result1 = await sessionManagementRepository.sendDataToBluetooth1(
      device: mad.madDevice!,
      data: bl1Data,
    );

    // ✅ Send data to BL2 (On-Time, Off-Time, Ramp)
    final bl2Data = madBluetoothData.formatDataForCharacteristic2();
    final result2 = await sessionManagementRepository.sendDataToBluetooth2(
      device: mad.madDevice!,
      data: bl2Data,
    );

    if (result1.isLeft() || result2.isLeft()) {
      emit(state.copyWith(
        status: SessionStatus.notReady,
        errorMessage: "Failed to send data to MAD",
      ));
    } else {
      print("✅ Data sent successfully to MAD ${mad.madNo}");
    }
  }

  List<int> _getPulseWidthValues() {
    List<int> pulseWidthValues = [];

    final selectedProgram = state.selectedProgram!;
    if (selectedProgram is CustomProgramEntity) {
      pulseWidthValues =
          selectedProgram.programMuscles.map((e) => e.pulse!.toInt()).toList();
    } else {
      pulseWidthValues = List.generate(10, (index) => selectedProgram.pulse);
    }
    return pulseWidthValues;
  }

  void setSessionMode(SessionControlMode sessionControlMode) {
    emit(state.copyWith(selectedSessionMode: sessionControlMode));
  }

  void setSessionDuration(Duration duration) {
    emit(state.copyWith(totalDuration: duration, currentDuration: duration));
  }

  void setCurrentProgram(ProgramEntity program) {
    emit(state.copyWith(
        selectedProgram: program,
        programsUsedInSession: [...state.programsUsedInSession, program]));
  }

  void _startProgramTimer() {
    _programTimer?.cancel();

    if (state.currentProgramDuration.inSeconds <= 0) return;

    // ✅ Fix: Force UI update *immediately* to prevent the 1-sec delay
    final remainingSessionTime = state.currentDuration.inSeconds;
    final isTransitioning = (state.currentProgramDuration.inSeconds <= 15) &&
        (remainingSessionTime > 15);

    emit(state.copyWith(
      isProgramTransitioning: isTransitioning,
    ));

    _programTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newDuration =
          state.currentProgramDuration - const Duration(seconds: 1);

      if (newDuration.inSeconds <= 0) {
        timer.cancel();
        _transitionToNextProgram();
      } else {
        emit(state.copyWith(
          currentProgramDuration: newDuration,
          isProgramTransitioning:
              (newDuration.inSeconds <= 15) && (remainingSessionTime > 15),
        ));
      }
    });
  }

  void _transitionToNextProgram() {
    final nextIndex = state.currentProgramIndex + 1;

    if (nextIndex >= state.automaticSessionprograms!.length) {
      stopSession(); // End session if all programs are completed
      return;
    }

    // Pause session before switching programs
    pauseSession();

    // Fetch next program
    final nextProgram = state.automaticSessionprograms![nextIndex];

    // ✅ Update muscle values for the new program
    _updateAllMuscleValues(nextProgram.pulse ?? 0);

    // ✅ Fix: Update `currentProgramDuration` to new program duration
    emit(state.copyWith(
      currentProgramIndex: nextIndex,
      currentProgramDuration: Duration(seconds: nextProgram.duration!),
      isProgramTransitioning: false, // Reset transition state
    ));
  }

  void _updateAllMuscleValues(int adjustment) {
    final updatedMads = state.controlPanelMads.map((mad) {
      final updatedMuscles = mad.musclesPercentage.map((muscle, value) {
        return MapEntry(
            muscle, (value + adjustment).clamp(0, double.infinity).toInt());
      });

      return mad.copyWith(musclesPercentage: updatedMuscles);
    }).toList();

    // Update selectedMads as well (first Mad is always selected in non-group mode)
    final updatedSelectedMads = state.selectedMads!.map((mad) {
      final updatedMuscles = mad.musclesPercentage.map((muscle, value) {
        return MapEntry(
            muscle, (value + adjustment).clamp(0, double.infinity).toInt());
      });

      return mad.copyWith(musclesPercentage: updatedMuscles);
    }).toList();

    emit(state.copyWith(
      controlPanelMads: updatedMads,
      selectedMads: updatedSelectedMads,
    ));
  }

  void setAutomaticSessionPrograms(List<SessionProgram> programs) {
    emit(state.copyWith(
        currentProgramDuration: Duration(seconds: programs[0].duration ?? 15),
        automaticSessionprograms: programs));
  }

  void setAllPrograms(List<ProgramEntity> programs) {
    emit(state.copyWith(allPrograms: programs));
  }

  void onClientMadAssign(UserEntity client, int index) {
    final mads = [...state.controlPanelMads];
    final updatedMad = mads[index].copyWith(client: client as ClientEntity);
    mads[index] = updatedMad;
    emit(state.copyWith(controlPanelMads: mads, selectedMads: [updatedMad]));
  }

  void onControlPanelMadTap(ControlPanelMad mad, int index) {
    if (state.isGroupMode) return; // ignore if group mode
    final mads = [...state.controlPanelMads];
    // if (!mad.isBluetoothConnected! || !mad.isHeartRateSensorConnected!) {
    //   mads[index] = mads[index].copyWith(
    //       isBluetoothConnected: true, isHeartRateSensorConnected: true);
    // }
    // ;

    emit(state.copyWith(selectedMads: [mads[index]], controlPanelMads: mads));
  }

  void onProgramSelected(ProgramEntity program) {
    pauseSession();
    setCurrentProgram(program);
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
    if (value < 0) return;

    sendDataToAllMads();

    final int newOnTime = value.toInt();

    emit(state.copyWith(
      onTime: newOnTime,
      currentOnTime: state.isOnCycle
          ? (state.currentOnTime >= newOnTime ? newOnTime : state.currentOnTime)
          : state.currentOnTime, // Update current timer if in On cycle
    ));

    if (state.status == SessionStatus.running && state.isOnCycle) {
      _startOnOffTimer(state.currentOnTime); // Restart timer dynamically
    }
  }

  void adjustOffTime(num value) {
    if (value < 0) return;

    sendDataToAllMads();
    final int newOffTime = value.toInt();

    emit(state.copyWith(
      offTime: newOffTime,
      currentOffTime: !state.isOnCycle
          ? (state.currentOffTime >= newOffTime
              ? newOffTime
              : state.currentOffTime)
          : state.currentOffTime, // Update current timer if in Off cycle
    ));

    if (state.status == SessionStatus.running && !state.isOnCycle) {
      _startOnOffTimer(state.currentOffTime); // Restart timer dynamically
    }
  }

  void adjustRamp(num value) {
    if (value < 0) {
      return;
    }
    sendDataToAllMads();
    emit(state.copyWith(ramp: value.toDouble()));
  }

  /// Adjusts a specific muscle value for the first selected Mad
  void adjustMuscleValue(String muscleKey, bool isIncrement) {
    // Block increment if the session is not running
    if (isIncrement && !state.isRunning) return;

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
    // update mad with new value via bluetooth
    sendDataToAllMads();
  }

  /// Increases all muscle values for the first selected Mad
  void increaseAllMuscles() {
    if (!state.isRunning) return;
    final updatedMuscles = _validateAndFetchMuscles();
    if (updatedMuscles == null) return;

    updatedMuscles.updateAll((key, value) => value + 1);
    _updateSelectedMad(updatedMuscles);
    // update mad with new value via bluetooth
    sendDataToAllMads();
  }

  /// Decreases all muscle values for the first selected Mad
  void decreaseAllMuscles() {
    final updatedMuscles = _validateAndFetchMuscles();
    if (updatedMuscles == null) return;

    updatedMuscles.updateAll(
        (key, value) => (value - 1).clamp(0, double.infinity).toInt());
    _updateSelectedMad(updatedMuscles);
    // update mad with new value via bluetooth
    sendDataToAllMads();
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

  @override
  Future<void> close() {
    // Dispose timers to free resources
    _sessionTimer?.cancel();
    _onOffTimer?.cancel();
    _programTimer?.cancel();

    // Call super.close to ensure proper Cubit closure
    return super.close();
  }

  bool _canStartSession() {
    // Ensure there is at least one selected Mad
    if (state.selectedMads == null || state.selectedMads!.isEmpty) {
      emit(state.copyWith(
        status: SessionStatus.notReady,
        errorMessage:
            "No Mad selected. Please select a Mad to start the session.",
      ));
      return false;
    }

    // Validate the first selected Mad
    final selectedMad = state.selectedMads!.first;

    // Check if the Mad has a client assigned
    if (selectedMad.client == null) {
      emit(state.copyWith(
        status: SessionStatus.notReady,
        errorMessage: "Selected Mad has no client assigned",
      ));
      return false;
    }

    // Check if Bluetooth and Heart Rate sensors are connected
    if (!selectedMad.isBluetoothConnected! ||
        !selectedMad.isHeartRateSensorConnected!) {
      emit(state.copyWith(
        status: SessionStatus.notReady,
        errorMessage:
            "Ensure Bluetooth and Heart Rate sensors are connected for the selected Mad.",
      ));
      return false;
    }

    // Prevent starting a session with zero duration
    if (state.totalDuration.inSeconds == 0) {
      emit(state.copyWith(
        status: SessionStatus.notReady,
        errorMessage:
            "Session duration cannot be zero. Please adjust the duration.",
      ));
      return false;
    }

    // All conditions are satisfied
    return true;
  }

  void startSession() {
    // Prevent starting a session with zero duration
    if (!_canStartSession()) return;

    emit(state.copyWith(status: SessionStatus.running));

    // Main session timer
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.currentDuration.inSeconds <= 0) {
        timer.cancel();
        stopSession();
      } else {
        // Calculate elapsed time
        final elapsedSeconds =
            state.totalDuration.inSeconds - state.currentDuration.inSeconds;

        // Check if 6 minutes (360 seconds) have passed count the session
        if (elapsedSeconds == 360 && !state.isSessionCounted) {
          emit(state.copyWith(isSessionCounted: true));
        }
        // Update current session duration
        emit(state.copyWith(
          currentDuration: state.currentDuration - const Duration(seconds: 1),
        ));
      }
    });

    if (state.selectedSessionMode == SessionControlMode.auto) {
      // start program timer if in auto mode
      _startProgramTimer();
    }
    // Start on/off timer
    _startOnOffTimer();
  }

  void pauseSession() {
    _sessionTimer?.cancel();
    _onOffTimer?.cancel();
    _programTimer?.cancel();
    // stop signal on mads
    sendDataToAllMads(isStopSignal: true);

    emit(state.copyWith(
      isOnCycle: true,
      currentOnTime: 0,
      currentOffTime: 0,
      isProgramTransitioning: false, // Hide transition UI
      status: SessionStatus.paused,
    ));
  }

  void stopSession() {
    _sessionTimer?.cancel();
    _onOffTimer?.cancel();
    _programTimer?.cancel();
    // stop signal on mads
    sendDataToAllMads(isStopSignal: true);

    emit(state.copyWith(
      status: SessionStatus.finished,
      currentDuration: state.totalDuration,
      onTime: state.onTime,
      offTime: state.offTime,
      isOnCycle: true,
      isProgramTransitioning: false,
      currentProgramIndex: 0,
      currentProgramDuration: Duration.zero,
    ));
  }

  void _startOnOffTimer([int? overrideCycleTime]) {
    _onOffTimer?.cancel();

    int currentCycleTime = overrideCycleTime ??
        (state.isOnCycle ? state.currentOnTime : state.currentOffTime);

    final int fullCycleValue = state.isOnCycle ? state.onTime : state.offTime;

    _onOffTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentCycleTime >= fullCycleValue) {
        emit(state.copyWith(
          isOnCycle: !state.isOnCycle, // Switch cycle
          currentOnTime: 0, // Reset On cycle
          currentOffTime: 0, // Reset Off cycle
        ));
        _startOnOffTimer(); // Restart with new cycle
      } else {
        currentCycleTime += 1;

        emit(state.copyWith(
          currentOnTime:
              state.isOnCycle ? currentCycleTime : state.currentOnTime,
          currentOffTime:
              !state.isOnCycle ? currentCycleTime : state.currentOffTime,
        ));
      }
    });
  }
}
