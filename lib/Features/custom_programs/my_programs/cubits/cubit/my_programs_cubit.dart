import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/data/services/custom_program_service.dart';

import '../../../../../Core/entities/programmer_entity.dart';

part 'my_programs_state.dart';

class MyProgramsCubit extends Cubit<MyProgramsState> {
  final CustomProgramService customProgramService;
  MyProgramsCubit({required this.customProgramService})
      : super(MyProgramsInitial());

  void deleteProgram({required int id, required int programIndex}) async {
    emit(state.copyWith(deleteRequestStatus: MyProgramsStatus.loading));
    final response = await customProgramService.deleteCustomProgram(id: id);
    response.fold(
      (failure) {
        emit(state.copyWith(
            deleteRequestStatus: MyProgramsStatus.error,
            message: failure.message));
      },
      (message) {
        _updateUserPrograms(programIndex);
        emit(state.copyWith(
            deleteRequestStatus: MyProgramsStatus.success, message: message));
      },
    );
  }

  void _updateUserPrograms(int programIndex) {
    final currentUser =
        (getIt<UserStateCubit>().state.currentUser as ProgrammerEntity);
    final userPrograms = [...currentUser.customPrograms!];
    userPrograms.removeAt(programIndex);
    final updatedUser = currentUser.copyWith(customPrograms: userPrograms);

    getIt<UserStateCubit>().setUser(updatedUser);
  }
}
