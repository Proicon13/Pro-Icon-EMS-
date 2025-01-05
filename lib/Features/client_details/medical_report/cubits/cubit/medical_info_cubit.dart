import 'package:bloc/bloc.dart';
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

  Future<void> renderHealthConditions(int clientId) async {
    emit(state.copyWith(status: ClientDetailsStatus.loading));

    final healthConditionsResponse =
        await healthConditionService.getAllHealthConditions();
    healthConditionsResponse.fold(
      (failure) => _handleFailure(failure),
      (healthConditions) async =>
          _fetchClientHealthConditions(clientId, healthConditions),
    );
  }

  Future<void> _fetchClientHealthConditions(
      int clientId, HealthConditionResponse healthConditions) async {
    final clientResponse = await healthConditionService
        .getClientHealthConditions(clientId: clientId);

    clientResponse.fold(
      (failure) => _handleFailure(failure),
      (clientHealthConditions) {
        emit(state.copyWith(
          allDiseases: healthConditions.diseases,
          allInjuries: healthConditions.injuries,
          clientDiseases: clientHealthConditions.diseases,
          clientInjuries: clientHealthConditions.injuries,
          status: ClientDetailsStatus.success,
        ));
      },
    );
  }

  void toggleInjurySection() {
    emit(state.copyWith(isInjurySectionOpen: !state.isInjurySectionOpen));
  }

  void toggleDiseaseSection() {
    emit(state.copyWith(isDiseaseSectionOpen: !state.isDiseaseSectionOpen));
  }

  Future<void> updateInjury(int clientId, int injuryId) async {
    emit(state.copyWith(status: ClientDetailsStatus.loading));

    final response = await healthConditionService.updateClientInjuries(
        clientId: clientId, injuryId: injuryId);
    response.fold(
      (failure) => _handleFailure(failure),
      (message) => _updateHealthCondition(
        conditionId: injuryId,
        conditionsList: state.clientInjuries,
        allConditions: state.allInjuries,
        updateType: 'injury',
        successMessage: message,
      ),
    );
  }

  Future<void> updateDisease(int clientId, int diseaseId) async {
    emit(state.copyWith(status: ClientDetailsStatus.loading));

    final response = await healthConditionService.updateClientDisease(
        clientId: clientId, diseaseId: diseaseId);
    response.fold(
      (failure) => _handleFailure(failure),
      (message) => _updateHealthCondition(
        conditionId: diseaseId,
        conditionsList: state.clientDiseases,
        allConditions: state.allDiseases,
        updateType: 'disease',
        successMessage: message,
      ),
    );
  }

  void _handleFailure(Failure failure) {
    emit(state.copyWith(
      status: ClientDetailsStatus.error,
      message: failure.message,
    ));
  }

  void _updateHealthCondition({
    required int conditionId,
    required List<HealthCondition> conditionsList,
    required List<HealthCondition> allConditions,
    required String updateType,
    required String successMessage,
  }) {
    final updatedConditions = List<HealthCondition>.from(conditionsList);

    if (updatedConditions.any((condition) => condition.id == conditionId)) {
      updatedConditions.removeWhere((condition) => condition.id == conditionId);
    } else {
      final condition = allConditions.firstWhere((c) => c.id == conditionId);
      updatedConditions.add(condition);
    }

    emit(state.copyWith(
      clientInjuries:
          updateType == 'injury' ? updatedConditions : state.clientInjuries,
      clientDiseases:
          updateType == 'disease' ? updatedConditions : state.clientDiseases,
      status: ClientDetailsStatus.success,
      message: successMessage,
    ));
  }
}
