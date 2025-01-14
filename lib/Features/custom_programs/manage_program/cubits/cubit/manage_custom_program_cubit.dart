import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/data/services/custom_program_service.dart';

part 'manage_custom_program_state.dart';

class ManageCustomProgramCubit extends Cubit<ManageCustomProgramState> {
  final CustomProgramService customProgramService;
  ManageCustomProgramCubit({required this.customProgramService})
      : super(const ManageCustomProgramState());

  void setStep(int step) => emit(state.copyWith(currentStep: step));
  void setProgram(ProgramEntity programEntity) =>
      emit(state.copyWith(customProgramEntity: programEntity));
}
