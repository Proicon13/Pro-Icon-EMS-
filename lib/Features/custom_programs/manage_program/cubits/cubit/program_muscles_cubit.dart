import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/programmer_entity.dart';
import 'package:pro_icon/data/models/add_custom_program_model.dart';
import 'package:pro_icon/data/models/muscle.dart';
import 'package:pro_icon/data/services/muscles_service.dart';

import '../../../../../Core/cubits/user_state/user_state_cubit.dart';
import '../../../../../Core/dependencies.dart';
import '../../../../../Core/entities/program_entity.dart';
import '../../../../../data/models/program_muscle.dart';
import '../../../../../data/services/custom_program_service.dart';

part 'program_muscles_state.dart';

class ProgramMusclesCubit extends Cubit<ProgramMusclesState> {
  final MusclesService musclesService;
  final CustomProgramService customProgramService;
  ProgramMusclesCubit(
      {required this.customProgramService, required this.musclesService})
      : super(const ProgramMusclesState());

  Timer? _debounceTimer;

  void setProgramMuscleMap(Map<Muscle, AddProgramMuscleModel> programMuscles) {
    emit(state.copyWith(programMuscles: programMuscles));
  }

  void updateMuscleValueDebounced(int programId, Muscle muscle,
      int programMuscleId, int newValue, bool isActive) {
    // Cancel any existing timer
    _debounceTimer?.cancel();

    // Start a new debounce timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _updateMuscleValue(
          programId, muscle, programMuscleId, newValue, isActive);
    });
  }

  /// The actual function to update muscle value or isActive (without debounce)
  Future<void> _updateMuscleValue(int programId, Muscle muscle,
      int programMuscleId, int newValue, bool isActive) async {
    final response = await customProgramService.updateProgramMuscle(
      body: {"value": newValue, "isActive": isActive},
      id: programMuscleId,
    );

    response.fold(
      (failure) {
        // Handle failure by emitting error state
        emit(state.copyWith(
          musclesUpdateStatus: ProgramMusclesStatus.error,
          message: failure.message,
        ));
      },
      (updatedProgramMuscle) {
        // Handle success
        _updateLocalMuscleState(muscle, updatedProgramMuscle);
        _updateUserProgramMuscles(programId, muscle, updatedProgramMuscle);
      },
    );
  }

  /// Updates the local state of the program muscles in the cubit
  void _updateLocalMuscleState(
      Muscle muscle, AddProgramMuscleModel updatedProgramMuscle) {
    final updatedProgramMuscles =
        Map<Muscle, AddProgramMuscleModel>.from(state.programMuscles!);

    // Update the map with the new program muscle
    updatedProgramMuscles[muscle] = updatedProgramMuscle;

    // Emit the updated state
    emit(state.copyWith(
      programMuscles: updatedProgramMuscles,
      musclesUpdateStatus: ProgramMusclesStatus.success,
      message: "",
    ));
  }

  /// Updates the user program muscles in the user state
  void _updateUserProgramMuscles(
      int programId, Muscle muscle, AddProgramMuscleModel newProgramMuscle) {
    // Fetch the current user
    final user = getIt<UserStateCubit>().state.currentUser as ProgrammerEntity;

    // Get a copy of the user's custom programs
    final customPrograms = List<ProgramEntity>.from(user.customPrograms!);

    // Get the desired custom program from the list
    final programIndex = customPrograms.indexWhere((p) => p.id == programId);
    if (programIndex == -1) return; // Exit if the program is not found
    final customProgram = customPrograms[programIndex] as CustomProgramEntity;

    // Get the desired program muscle object from the custom program's programMuscles list
    final programMuscles =
        List<ProgramMuscle>.from(customProgram.programMuscles);
    final muscleIndex =
        programMuscles.indexWhere((m) => m.id == newProgramMuscle.muscleId);
    if (muscleIndex == -1) return; // Exit if the muscle is not found

    // Update the desired programMuscle object with values from updatedProgramMuscle
    final updatedProgramMuscle = programMuscles[muscleIndex].copyWith(
      isActive: newProgramMuscle.isActive,
      pulse: newProgramMuscle.value,
    );
    programMuscles[muscleIndex] = updatedProgramMuscle;

    // Create an updated custom program with the modified programMuscles
    final updatedCustomProgram = customProgram.copyWith(
      programMuscles: programMuscles,
    );

    // Update the custom program in the customPrograms list
    customPrograms[programIndex] = updatedCustomProgram;

    // Update the user with the modified custom programs
    final updatedUser = user.copyWith(customPrograms: customPrograms);

    // Update the user state in the UserStateCubit
    getIt<UserStateCubit>().setUser(updatedUser);
  }

  @override
  Future<void> close() {
    // Cancel debounce timer when the cubit is closed
    _debounceTimer?.cancel();
    return super.close();
  }

  void fetchMuscles(CustomProgramEntity? program) async {
    emit(state.copyWith(musclesRequestStatus: ProgramMusclesStatus.loading));
    final result = await musclesService.getMuscles();
    result.fold(
        (failure) => emit(state.copyWith(
            musclesRequestStatus: ProgramMusclesStatus.error,
            message: failure.message)), (muscles) {
      // populate muscles Map
      final programMuscles = populateProgramMuscles(program, muscles);

      emit(state.copyWith(
          musclesRequestStatus: ProgramMusclesStatus.success,
          programMuscles: programMuscles,
          message: ""));
    });
  }
}

Map<Muscle, AddProgramMuscleModel> populateProgramMuscles(
    CustomProgramEntity? program, List<Muscle> muscles) {
  // Create a Map<int, ProgramMuscle> for efficient lookups in edit mode
  Map<int, ProgramMuscle>? existingProgramMuscles;
  if (program != null) {
    existingProgramMuscles = {
      for (var muscleModel in program.programMuscles)
        muscleModel.muscle!.id!: muscleModel,
    };
  }

  // Populate the programMuscles map
  return {
    for (var muscle in muscles)
      muscle: AddProgramMuscleModel(
        isActive: program == null
            ? true // Default value for create mode
            : existingProgramMuscles?[muscle.id]?.isActive ??
                true, // Use existing or default
        muscleId: program == null
            ? muscle.id
            : existingProgramMuscles?[muscle.id]?.id,
        value: program == null
            ? 0 // Default value for create mode
            : existingProgramMuscles?[muscle.id]?.pulse ??
                0, // Use existing or default
      ),
  };
}
