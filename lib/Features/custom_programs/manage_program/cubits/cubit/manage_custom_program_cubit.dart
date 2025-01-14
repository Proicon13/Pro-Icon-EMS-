import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/data/models/cycle.dart';
import 'package:pro_icon/data/services/custom_program_service.dart';

import '../../../../../data/models/program_muscle.dart';

part 'manage_custom_program_state.dart';

class ManageCustomProgramCubit extends Cubit<ManageCustomProgramState> {
  final CustomProgramService customProgramService;
  ManageCustomProgramCubit({required this.customProgramService})
      : super(const ManageCustomProgramState());

  void setStep(int step) => emit(state.copyWith(currentStep: step));
  void setProgram(ProgramEntity programEntity) =>
      emit(state.copyWith(customProgramEntity: programEntity));
  void setCycles(List<Cycle> cycles) {
    final updatedProgramCycles =
        (state.customProgramEntity! as CustomProgramEntity)
            .copyWith(cycles: cycles);
    setProgram(updatedProgramCycles);
  }

  void incrementCycleAdjustment(int cycleId) {
    final cycle = state.cycles.firstWhere((element) => element.id == cycleId);
    final updatedCycle = cycle.copyWith(adjustment: cycle.adjustment! + 1);
    final updatedCycles = List<Cycle>.from(state.cycles);
    updatedCycles[updatedCycles.indexOf(cycle)] = updatedCycle;
    setCycles(updatedCycles);
  }

  void decrementCycleAdjustment(int cycleId) {
    final cycle = state.cycles.firstWhere((element) => element.id == cycleId);
    final updatedCycle = cycle.copyWith(adjustment: cycle.adjustment! - 1);
    final updatedCycles = List<Cycle>.from(state.cycles);
    updatedCycles[updatedCycles.indexOf(cycle)] = updatedCycle;
    setCycles(updatedCycles);
  }
}
