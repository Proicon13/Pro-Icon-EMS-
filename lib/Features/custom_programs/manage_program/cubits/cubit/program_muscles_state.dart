part of 'program_muscles_cubit.dart';

enum ProgramMusclesStatus { initial, loading, success, error }

class ProgramMusclesState extends Equatable {
  final ProgramMusclesStatus? musclesRequestStatus;
  final ProgramMusclesStatus? musclesUpdateStatus;
  final String? message;
  final Map<Muscle, AddProgramMuscleModel>? programMuscles;
  const ProgramMusclesState({
    this.musclesRequestStatus = ProgramMusclesStatus.initial,
    this.musclesUpdateStatus = ProgramMusclesStatus.initial,
    this.message = "",
    this.programMuscles = const {},
  });

  ProgramMusclesState copyWith({
    ProgramMusclesStatus? musclesRequestStatus,
    ProgramMusclesStatus? musclesUpdateStatus,
    String? message,
    Map<Muscle, AddProgramMuscleModel>? programMuscles,
  }) {
    return ProgramMusclesState(
      musclesRequestStatus: musclesRequestStatus ?? this.musclesRequestStatus,
      musclesUpdateStatus: musclesUpdateStatus ?? this.musclesUpdateStatus,
      message: message ?? this.message,
      programMuscles: programMuscles ?? this.programMuscles,
    );
  }

  @override
  List<Object> get props =>
      [musclesRequestStatus!, musclesUpdateStatus!, message!, programMuscles!];
}
