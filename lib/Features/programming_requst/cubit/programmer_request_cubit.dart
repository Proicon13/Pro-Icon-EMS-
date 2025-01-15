import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/entities/admin_entity.dart';
import 'package:pro_icon/data/services/programmer_request.dart';

part 'programmer_request_state.dart';

class ProgrammerRequestCubit extends Cubit<ProgrammerRequestState> {
  final ProgrammerRequestService programmerRequestService;

  ProgrammerRequestCubit({required this.programmerRequestService})
      : super(const ProgrammerRequestState());

  void setApplyStatus(ProgrammerRequestStatus status) =>
      emit(state.copyWith(applyStatus: status));
  void applyForProgrammer() async {
    emit(state.copyWith(applyStatus: ProgrammerRequestStatus.loading));
    final result = await programmerRequestService.applyForProgrammer();

    result.fold(
        (error) => {
              emit(state.copyWith(
                  message: error.message,
                  applyStatus: ProgrammerRequestStatus.error))
            },
        (request) => {
              emit(state.copyWith(
                  message: "Successfully Applied request",
                  applyStatus: ProgrammerRequestStatus.success))
            });
  }

  void checkRequestStatus() async {
    emit(state.copyWith(checkStatus: ProgrammerRequestStatus.loading));
    final result = await programmerRequestService.checkForRequest();

    result.fold((error) {
      emit(state.copyWith(
          message: error.message, checkStatus: ProgrammerRequestStatus.error));
    }, (request) {
      // update the user request state
      final updatedUser =
          (getIt<UserStateCubit>().state.currentUser! as AdminEntity)
              .copyWith(programmingRequest: request);
      getIt<UserStateCubit>().setUser(updatedUser);
      emit(state.copyWith(
          message: "", checkStatus: ProgrammerRequestStatus.success));
    });
  }
}
