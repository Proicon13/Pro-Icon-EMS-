import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/app_user_model.dart';
import 'package:pro_icon/data/services/trainer_service.dart';

part 'user_managment_state.dart';

class UserManagmentCubit extends Cubit<UserManagmentState> {
  final TrainerService trainerService;
  UserManagmentCubit({required this.trainerService})
      : super(const UserManagmentState());

  Future<void> getTrainers() async {
    final response = await trainerService.getTrainers();
    response.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message,
            requestStatus: RequestStatus.error)), (trainers) {
      emit(state.copyWith(
          trainers: trainers,
          errorMessage: "",
          requestStatus: RequestStatus.loaded));
    });
  }
}
