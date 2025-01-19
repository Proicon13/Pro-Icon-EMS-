import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/sign_up_request.dart';

import '../../../../data/services/trainer_service.dart';

part 'trainer_password_state.dart';

class TrainerPasswordCubit extends Cubit<TrainerPasswordState> {
  final TrainerService trainerService;
  TrainerPasswordCubit({required this.trainerService})
      : super(const TrainerPasswordState());

  Future<void> registerTrainer({required SignupRequest signUpRequest}) async {
    emit(state.copyWith(status: RequestStatus.submitting));

    final response =
        await trainerService.addTrainerByAdmin(body: signUpRequest);
    response.fold(
        (failure) => emit(state.copyWith(
            status: RequestStatus.error, message: failure.message)),
        (success) => emit(state.copyWith(
            status: RequestStatus.success,
            message: "Trainer Added Successfully")));
  }
}
