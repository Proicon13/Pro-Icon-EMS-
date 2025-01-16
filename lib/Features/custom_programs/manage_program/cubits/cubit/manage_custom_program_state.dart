part of 'manage_custom_program_cubit.dart';

enum RequetsStatus { intial, loading, success, error }

extension ManageCustomProgramStatusX on ManageCustomProgramState {
  bool get isEditMode => this
      .customProgramEntity!
      .name
      .isNotEmpty; // if name is not empty so in edit mode
  List<Cycle> get cycles =>
      (this.customProgramEntity! as CustomProgramEntity).cycles;
}

class ManageCustomProgramState extends Equatable {
  final int? currentStep;
  final RequetsStatus? muscleStatus;
  final RequetsStatus? updateCycleStatus;
  final RequetsStatus? updateProgramMuscleStatus;
  final RequetsStatus? addProgramStatus;
  final RequetsStatus? updateProgramStatus;
  final String? message;
  final ProgramEntity? customProgramEntity;
  final Map<int, ProgramMuscle>? programMuscles;

  const ManageCustomProgramState({
    this.currentStep = 0,
    this.muscleStatus = RequetsStatus.intial,
    this.updateCycleStatus = RequetsStatus.intial,
    this.updateProgramMuscleStatus = RequetsStatus.intial,
    this.addProgramStatus = RequetsStatus.intial,
    this.updateProgramStatus = RequetsStatus.intial,
    this.message = "",
    this.programMuscles = const {},
    this.customProgramEntity = const CustomProgramEntity(
        id: 0,
        name: "",
        description: "",
        duration: 0,
        image: "",
        createdById: 0,
        pulse: 0,
        hertez: 0,
        categoryId: 0,
        stimulation: 0,
        pauseInterval: 0,
        contraction: 0,
        programMuscles: [],
        cycles: []),
  });

  ManageCustomProgramState copyWith({
    int? currentStep,
    RequetsStatus? muscleStatus,
    RequetsStatus? updateCycleStatus,
    RequetsStatus? updateProgramMuscleStatus,
    RequetsStatus? addProgramStatus,
    RequetsStatus? updateProgramStatus,
    String? message,
    ProgramEntity? customProgramEntity,
    Map<int, ProgramMuscle>? programMuscles,
  }) {
    return ManageCustomProgramState(
      currentStep: currentStep ?? this.currentStep,
      muscleStatus: muscleStatus ?? this.muscleStatus,
      updateCycleStatus: updateCycleStatus ?? this.updateCycleStatus,
      updateProgramMuscleStatus:
          updateProgramMuscleStatus ?? this.updateProgramMuscleStatus,
      message: message ?? this.message,
      customProgramEntity: customProgramEntity ?? this.customProgramEntity,
      programMuscles: programMuscles ?? this.programMuscles,
      addProgramStatus: addProgramStatus ?? this.addProgramStatus,
      updateProgramStatus: updateProgramStatus ?? this.updateProgramStatus,
    );
  }

  @override
  List<Object> get props => [
        currentStep!,
        muscleStatus!,
        updateCycleStatus!,
        updateProgramMuscleStatus!,
        message!,
        customProgramEntity!,
        programMuscles!,
        isEditMode,
        cycles,
        addProgramStatus!
      ];
}
