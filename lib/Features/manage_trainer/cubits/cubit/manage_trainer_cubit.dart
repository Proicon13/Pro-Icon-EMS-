import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/services/trainer_service.dart';

part 'manage_trainer_state.dart';

class ManageTrainerCubit extends Cubit<ManageTrainerState> {
  final TrainerService trainerService;
  ManageTrainerCubit({required this.trainerService})
      : super(const ManageTrainerState());

  Future<void> editTrainer(int id, Map<String, dynamic> body) async {
    emit(state.copyWith(requestStataus: ManageTrainerStatus.loading));
    final result =
        await trainerService.updateTrainerDetails(body: body, id: id);
    result.fold((failure) {
      emit(state.copyWith(
          requestStataus: ManageTrainerStatus.error, message: failure.message));
    }, (trainer) {
      emit(state.copyWith(
          requestStataus: ManageTrainerStatus.success,
          message: "Updated Successfully"));
    });
  }
}
