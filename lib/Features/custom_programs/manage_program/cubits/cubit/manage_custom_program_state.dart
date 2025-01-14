part of 'manage_custom_program_cubit.dart';

enum RequetsStatus { intial, loading, success, error }

extension ManageCustomProgramStatusX on ManageCustomProgramState {
  bool get isEditMode => this
      .customProgramEntity!
      .name
      .isNotEmpty; // if name is not empty so in edit mode
}

class ManageCustomProgramState extends Equatable {
  final int? currentStep;
  final RequetsStatus? muscleStatus;
  final RequetsStatus? updateCycleStatus;
  final RequetsStatus? updateProgramMuscleStatus;
  final String? message;
  final ProgramEntity? customProgramEntity;

  const ManageCustomProgramState({
    this.currentStep = 0,
    this.muscleStatus = RequetsStatus.intial,
    this.updateCycleStatus = RequetsStatus.intial,
    this.updateProgramMuscleStatus = RequetsStatus.intial,
    this.message = "",
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
    String? message,
    ProgramEntity? customProgramEntity,
  }) {
    return ManageCustomProgramState(
      currentStep: currentStep ?? this.currentStep,
      muscleStatus: muscleStatus ?? this.muscleStatus,
      updateCycleStatus: updateCycleStatus ?? this.updateCycleStatus,
      updateProgramMuscleStatus:
          updateProgramMuscleStatus ?? this.updateProgramMuscleStatus,
      message: message ?? this.message,
      customProgramEntity: customProgramEntity ?? this.customProgramEntity,
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
      ];
}
