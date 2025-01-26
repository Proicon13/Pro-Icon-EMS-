part of 'control_panel_cubit.dart';

enum SessionStatus {
  initial,
  intializing,
  ready,
  running,
  paused,
  stopped,
  error,
}

extension SessionStatusExtension on ControlPanelState {
  bool get isInitial => this.status == SessionStatus.initial;
  bool get isInitializing => this.status == SessionStatus.intializing;
  bool get isRunning => this.status == SessionStatus.running;
  bool get isPaused => this.status == SessionStatus.paused;
  bool get isStopped => this.status == SessionStatus.stopped;
  bool get isError => this.status == SessionStatus.error;
  bool get isReady => this.status == SessionStatus.ready;
}

class ControlPanelState extends Equatable {
  final SessionStatus status;
  final SessionControlMode? selectedSessionMode;
  final List<ControlPanelMad> controlPanelMads;
  final Map<String, int> sharedMuscles; // Shared muscle map for group mode
  final List<ControlPanelMad>?
      selectedMads; // Selected Mads for individual mode
  final String? errorMessage;
  final bool isGroupMode; // True if group mode is active
  final Duration totalDuration; // Total session duration
  final int onTime; // On timer duration
  final int offTime; // Off timer duration
  final double ramp; // Ramp acceleration value
  final ProgramEntity?
      selectedProgram; // selected program for manual mode (Program mode)
  final List<SessionProgram>?
      automaticSessionprograms; // List of programs> IF AUTOMATIC SESSION MODE APPLIED

  final List<ProgramEntity> allPrograms; // List of all programs in program mode
  const ControlPanelState({
    this.status = SessionStatus.initial,
    this.selectedSessionMode = SessionControlMode.program,
    this.controlPanelMads = const [],
    this.sharedMuscles = const {},
    this.selectedMads = const [],
    this.allPrograms = const [],
    this.errorMessage = "",
    this.isGroupMode = false,
    this.totalDuration = const Duration(minutes: 25),
    this.onTime = 0,
    this.offTime = 0,
    this.ramp = 0,
    this.selectedProgram,
    this.automaticSessionprograms = const [],
  });

  ControlPanelState copyWith({
    SessionStatus? status,
    SessionControlMode? selectedSessionMode,
    List<ControlPanelMad>? controlPanelMads,
    Map<String, int>? sharedMuscles,
    List<ControlPanelMad>? selectedMads,
    String? errorMessage,
    bool? isGroupMode,
    Duration? totalDuration,
    int? onTime,
    int? offTime,
    double? ramp,
    ProgramEntity? selectedProgram,
    List<SessionProgram>? automaticSessionprograms,
    List<ProgramEntity>? allPrograms,
  }) {
    return ControlPanelState(
      status: status ?? this.status,
      controlPanelMads: controlPanelMads ?? this.controlPanelMads,
      sharedMuscles: sharedMuscles ?? this.sharedMuscles,
      selectedMads: selectedMads ?? this.selectedMads,
      errorMessage: errorMessage ?? this.errorMessage,
      isGroupMode: isGroupMode ?? this.isGroupMode,
      totalDuration: totalDuration ?? this.totalDuration,
      onTime: onTime ?? this.onTime,
      offTime: offTime ?? this.offTime,
      ramp: ramp ?? this.ramp,
      selectedProgram: selectedProgram ?? this.selectedProgram,
      automaticSessionprograms:
          automaticSessionprograms ?? this.automaticSessionprograms,
      allPrograms: allPrograms ?? this.allPrograms,
      selectedSessionMode: selectedSessionMode ?? this.selectedSessionMode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        controlPanelMads,
        sharedMuscles,
        selectedMads,
        errorMessage,
        isGroupMode,
        totalDuration,
        onTime,
        offTime,
        ramp,
        selectedProgram,
        automaticSessionprograms,
        allPrograms,
        selectedSessionMode
      ];
}
