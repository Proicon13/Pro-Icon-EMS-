import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/entities/programmer_entity.dart';
import 'package:pro_icon/Core/utils/image_picker.dart';
import 'package:pro_icon/data/models/cycle.dart';
import 'package:pro_icon/data/services/custom_program_service.dart';

import '../../../../../Core/dependencies.dart';
import '../../../../../data/models/add_custom_program_model.dart';
import '../../../../../data/models/program_muscle.dart';

part 'manage_custom_program_state.dart';

class ManageCustomProgramCubit extends Cubit<ManageCustomProgramState> {
  final CustomProgramService customProgramService;
  ManageCustomProgramCubit({required this.customProgramService})
      : super(const ManageCustomProgramState());

  void pickImage() async {
    final image = await ImagePickerHelper().pickImage();
    if (image != null) {
      final updatedProgramImage =
          (state.customProgramEntity! as CustomProgramEntity)
              .copyWith(image: image.path);
      setProgram(updatedProgramImage);
    }
  }

  void setStep(int step) => emit(state.copyWith(currentStep: step));
  void setProgram(ProgramEntity programEntity) =>
      emit(state.copyWith(customProgramEntity: programEntity));
  void setCycles(List<Cycle> cycles) {
    final updatedProgramCycles =
        (state.customProgramEntity! as CustomProgramEntity)
            .copyWith(cycles: cycles);
    setProgram(updatedProgramCycles);
  }

  void setUpdateProgramStatus(RequetsStatus status) =>
      emit(state.copyWith(updateProgramStatus: status));

  void onCyclesSelected(int numberOfCycles) {
    if (numberOfCycles < 1) return setCycles([]);
    if (numberOfCycles > 6) return;

    // Retrieve the current list of cycles
    final currentCycles = List<Cycle>.from(state
        .cycles); // Replace this with how you access the current cycles in state

    // If the selected number of cycles is greater than the existing cycles, append the difference
    if (numberOfCycles > currentCycles.length) {
      final newCycles = List<Cycle>.generate(
        (numberOfCycles - currentCycles.length),
        (index) => Cycle(
          id: currentCycles.length + index,
          adjustment: 0,
          frequency: 0,
        ),
      );

      setCycles([...currentCycles, ...newCycles]);
    }
    // If the selected number of cycles is less than or equal to the existing cycles, trim the list
    else {
      setCycles(currentCycles.take(numberOfCycles).toList());
    }
  }

  void updateCycleAdjustment(int cycleId, int increment) {
    // Create a mutable copy of the list
    final updatedCycles = List<Cycle>.from(state.cycles);

    // Find the index of the cycle to update
    final index = updatedCycles.indexWhere((cycle) => cycle.id == cycleId);
    if (index == -1) return; // If the cycle is not found, exit

    // Create a new updated cycle
    final updatedCycle = updatedCycles[index].copyWith(
      adjustment: (updatedCycles[index].adjustment ?? 0) + increment,
    );

    // Replace the old cycle with the updated one
    updatedCycles[index] = updatedCycle;

    // Update the state with the new list
    setCycles(updatedCycles);
  }

  void incrementCycleAdjustment(int cycleId) {
    updateCycleAdjustment(cycleId, 1);
  }

  void decrementCycleAdjustment(int cycleId) {
    updateCycleAdjustment(cycleId, -1);
  }

  void addCustomProgram(AddCustomProgramModel addRequest) async {
    emit(state.copyWith(addProgramStatus: RequetsStatus.loading));
    final response = await customProgramService.createCustomProgram(
        customProgramRequest: addRequest);
    response.fold(
      (failure) {
        emit(state.copyWith(
            addProgramStatus: RequetsStatus.error, message: failure.message));
      },
      (program) {
        _updateUserPrograms(program);
        emit(state.copyWith(
            addProgramStatus: RequetsStatus.success,
            message: "Program Added Successfully"));
      },
    );
  }

  void updateCustomProgram(Map<String, dynamic> body, int id) async {
    emit(state.copyWith(updateProgramStatus: RequetsStatus.loading));
    final response =
        await customProgramService.updateCustomProgram(id: id, body: body);
    response.fold(
      (failure) {
        emit(state.copyWith(
            updateProgramStatus: RequetsStatus.error,
            message: failure.message));
      },
      (program) {
        _updateUserPrograms(program);
        emit(state.copyWith(
            addProgramStatus: RequetsStatus.success,
            message: "Program Updated Successfully"));
      },
    );
  }

  void removeCycle(int cycleId) {
    // Create a mutable copy of the cycles list
    final updatedCycles = List<Cycle>.from(state.cycles);

    // Remove the cycle with the specified ID
    updatedCycles.removeWhere((cycle) => cycle.id == cycleId);

    // Update the state with the new list
    setCycles(updatedCycles);
  }

  void _updateUserPrograms(ProgramEntity program) {
    final user = getIt<UserStateCubit>().state.currentUser as ProgrammerEntity;
    final updatedUserProgram = user.copyWith(
        customPrograms: List.from(user.customPrograms!)..add(program));
    getIt<UserStateCubit>().setUser(updatedUserProgram);
  }
}
