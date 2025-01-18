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

  final RequetsStatus? updateCycleStatus;

  final RequetsStatus? addProgramStatus;
  final RequetsStatus? updateProgramStatus;
  final String? message;
  final ProgramEntity? customProgramEntity;

  const ManageCustomProgramState({
    this.currentStep = 0,
    this.updateCycleStatus = RequetsStatus.intial,
    this.addProgramStatus = RequetsStatus.intial,
    this.updateProgramStatus = RequetsStatus.intial,
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
    RequetsStatus? addProgramStatus,
    RequetsStatus? updateProgramStatus,
    String? message,
    ProgramEntity? customProgramEntity,
  }) {
    return ManageCustomProgramState(
      currentStep: currentStep ?? this.currentStep,
      updateCycleStatus: updateCycleStatus ?? this.updateCycleStatus,
      message: message ?? this.message,
      customProgramEntity: customProgramEntity ?? this.customProgramEntity,
      addProgramStatus: addProgramStatus ?? this.addProgramStatus,
      updateProgramStatus: updateProgramStatus ?? this.updateProgramStatus,
    );
  }

  @override
  List<Object> get props => [
        currentStep!,
        updateCycleStatus!,
        message!,
        customProgramEntity!,
        isEditMode,
        cycles,
        addProgramStatus!,
        updateProgramStatus!
      ];
}
