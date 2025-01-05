import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/health_condition_response.dart';
import 'package:pro_icon/data/services/health_condition_service.dart';

import '../../../../../Core/errors/failures.dart';
import '../../../../../data/models/health_condition.dart';
import '../../../cubit/cubit/client_details_cubit.dart';

part 'medical_info_state.dart';

class MedicalInfoCubit extends Cubit<MedicalInfoState> {
  final HealthConditionService healthConditionService;
  MedicalInfoCubit({required this.healthConditionService})
      : super(const MedicalInfoState());

  void renderHealthConditions(int clientId) async {
    emit(state.copyWith(status: ClientDetailsStatus.loading));
    final response = await healthConditionService.getAllHealthConditions();
    response.fold(
        (failure) => emit(state.copyWith(
            status: ClientDetailsStatus.error,
            message: failure.message)), (healthConditions) async {
      // get client health conditions to render
      final clientResponse = await _getClientHealthConditions(clientId);
      clientResponse.fold(
          (failure) => emit(state.copyWith(
              status: ClientDetailsStatus.error,
              message: failure.message)), (clientHealthConditions) {
        emit(state.copyWith(
          allDiseases: healthConditions.diseases,
          allInjuries: healthConditions.injuries,
          clientDiseases: clientHealthConditions.diseases,
          clientInjuries: clientHealthConditions.injuries,
          status: ClientDetailsStatus.success,
        ));
      });
    });
  }

  Future<Either<Failure, HealthConditionResponse>> _getClientHealthConditions(
      int clientId) async {
    final response = await healthConditionService.getClientHealthConditions(
        clientId: clientId);
    return response.fold((failure) => Left(failure),
        (healthConditions) => Right(healthConditions));
  }
}
