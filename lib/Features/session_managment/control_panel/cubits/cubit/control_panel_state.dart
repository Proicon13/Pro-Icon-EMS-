part of 'control_panel_cubit.dart';

enum SessionStatus {
  initial,
  intializing,
  notReady,
  ready,
  running,
  paused,
  finished,
  error,
}

extension SessionStatusExtension on ControlPanelState {
  bool get isInitial => this.status == SessionStatus.initial;
  bool get isInitializing => this.status == SessionStatus.intializing;
  bool get isRunning => this.status == SessionStatus.running;
  bool get isPaused => this.status == SessionStatus.paused;
  bool get isStopped => this.status == SessionStatus.finished;
  bool get isError => this.status == SessionStatus.error;
  bool get isReady => this.status == SessionStatus.ready;
  bool get isNotReady => this.status == SessionStatus.notReady;
}

class ControlPanelState extends Equatable {
  final SessionStatus status;
  final int? sessionId;
  final RequetsStatus saveSessionStatus;
  final bool isSessionCounted;
  final List<BluetoothDevice> availableDevices; // List of paired devices>
  final int currentProgramIndex; // Which program is active
  final Duration
      currentProgramDuration; // Remaining time for the current program
  final bool
      isProgramTransitioning; // show transition timer or not for next program
  final bool isScanning;
  final SessionControlMode? selectedSessionMode;
  final List<ControlPanelMad> controlPanelMads;

  final List<ControlPanelMad>?
      selectedMads; // Selected Mads for individual mode
  final String? errorMessage;
  final bool isGroupMode; // True if group mode is active
  final Duration totalDuration; // Full duration of the session
  final Duration currentDuration; // Dynamic countdown for the session
  final int onTime; // Full On value
  final int offTime; // Full Off value
  final int currentOnTime; // Dynamic On countdown
  final int currentOffTime; // Dynamic Off countdown
  final double ramp; // ramp
  final ProgramEntity?
      selectedProgram; // selected program for manual mode (Program mode)
  final List<SessionProgram>?
      automaticSessionprograms; // List of programs> IF AUTOMATIC SESSION MODE APPLIED
  final bool isOnCycle;
  final List<ProgramEntity> allPrograms; // List of all programs in program mode
  final List<ProgramEntity> programsUsedInSession;
  const ControlPanelState({
    this.status = SessionStatus.initial,
    this.sessionId = -1,
    this.saveSessionStatus = RequetsStatus.intial,
    this.isScanning = false,
    this.isSessionCounted = false,
    this.currentProgramIndex = 0,
    this.currentProgramDuration = Duration.zero,
    this.isProgramTransitioning = false,
    this.programsUsedInSession = const [],
    this.currentDuration = const Duration(minutes: 25),
    this.currentOnTime = 0,
    this.currentOffTime = 0,
    this.selectedSessionMode = SessionControlMode.program,
    this.controlPanelMads = const [],
    this.availableDevices = const [],
    this.selectedMads = const [],
    this.allPrograms = const [],
    this.errorMessage = "",
    this.isGroupMode = false,
    this.isOnCycle = true,
    this.totalDuration = const Duration(minutes: 25),
    this.onTime = 8,
    this.offTime = 8,
    this.ramp = 0,
    this.selectedProgram,
    this.automaticSessionprograms = const [],
  });

  ControlPanelState copyWith(
      {SessionStatus? status,
      bool? isScanning,
      int? currentProgramIndex,
      Duration? currentProgramDuration,
      bool? isProgramTransitioning,
      SessionControlMode? selectedSessionMode,
      List<ControlPanelMad>? controlPanelMads,
      Map<String, int>? sharedMuscles,
      List<ControlPanelMad>? selectedMads,
      String? errorMessage,
      bool? isGroupMode,
      Duration? totalDuration,
      Duration? currentDuration,
      int? currentOnTime,
      int? currentOffTime,
      List<ProgramEntity>? programsUsedInSession,
      int? onTime,
      int? offTime,
      double? ramp,
      bool? isOnCycle,
      ProgramEntity? selectedProgram,
      List<SessionProgram>? automaticSessionprograms,
      List<ProgramEntity>? allPrograms,
      List<BluetoothDevice>? availableDevices,
      bool? isSessionCounted,
      RequetsStatus? saveSessionStatus,
      int? sessionId}) {
    return ControlPanelState(
        status: status ?? this.status,
        isScanning: isScanning ?? this.isScanning,
        controlPanelMads: controlPanelMads ?? this.controlPanelMads,
        availableDevices: availableDevices ?? this.availableDevices,
        selectedMads: selectedMads ?? this.selectedMads,
        errorMessage: errorMessage ?? this.errorMessage,
        isGroupMode: isGroupMode ?? this.isGroupMode,
        totalDuration: totalDuration ?? this.totalDuration,
        onTime: onTime ?? this.onTime,
        offTime: offTime ?? this.offTime,
        ramp: ramp ?? this.ramp,
        isOnCycle: isOnCycle ?? this.isOnCycle,
        selectedProgram: selectedProgram ?? this.selectedProgram,
        automaticSessionprograms:
            automaticSessionprograms ?? this.automaticSessionprograms,
        allPrograms: allPrograms ?? this.allPrograms,
        selectedSessionMode: selectedSessionMode ?? this.selectedSessionMode,
        currentDuration: currentDuration ?? this.currentDuration,
        currentOnTime: currentOnTime ?? this.currentOnTime,
        currentOffTime: currentOffTime ?? this.currentOffTime,
        programsUsedInSession:
            programsUsedInSession ?? this.programsUsedInSession,
        currentProgramIndex: currentProgramIndex ?? this.currentProgramIndex,
        currentProgramDuration:
            currentProgramDuration ?? this.currentProgramDuration,
        isProgramTransitioning:
            isProgramTransitioning ?? this.isProgramTransitioning,
        isSessionCounted: isSessionCounted ?? this.isSessionCounted,
        saveSessionStatus: saveSessionStatus ?? this.saveSessionStatus,
        sessionId: sessionId ?? this.sessionId);
  }

  @override
  List<Object?> get props => [
        status,
        isScanning,
        controlPanelMads,
        availableDevices,
        selectedMads,
        errorMessage,
        isGroupMode,
        totalDuration,
        onTime,
        offTime,
        currentDuration,
        currentOnTime,
        currentOffTime,
        ramp,
        selectedProgram,
        automaticSessionprograms,
        allPrograms,
        selectedSessionMode,
        isOnCycle,
        programsUsedInSession,
        currentProgramIndex,
        currentProgramDuration,
        isProgramTransitioning,
        isSessionCounted,
        saveSessionStatus,
        sessionId
      ];
}
