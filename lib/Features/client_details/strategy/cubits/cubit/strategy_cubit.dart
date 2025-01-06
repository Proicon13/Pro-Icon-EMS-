import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/utils/enums/training_types.dart';
import 'package:pro_icon/data/services/client_strategy_service.dart';

import '../../../../../data/models/client_strategy.dart';

part 'strategy_state.dart';

class StrategyCubit extends Cubit<StrategyState> {
  final ClientStrategyService clientStrategyService;
  StrategyCubit({required this.clientStrategyService})
      : super(const StrategyState());

  void setTrainingType(TrainingTypes trainingType) {
    emit(state.copyWith(currentTrainingType: trainingType));
  }

  void updateStatus(StrategyStatus status) =>
      emit(state.copyWith(strategyUpdateStatus: status));

  void toggleIsSectionOpen() =>
      emit(state.copyWith(isTrainingTypesopen: !state.isTrainingTypesopen!));
  void toggleIsTargetSectionOpen() =>
      emit(state.copyWith(isTargetSectionOpen: !state.isTargetSectionOpen!));

  Future<void> getClientStrategy(int clientId) async {
    emit(state.copyWith(strategyStatus: StrategyStatus.loading));
    final response =
        await clientStrategyService.getClientStrategy(clientId: clientId);
    emit(response.fold(
        (l) => state.copyWith(
            strategyStatus: StrategyStatus.error, message: l.message),
        (strategy) => state.copyWith(
            message: "",
            clientStrategy: strategy,
            currentTrainingType: strategy.trainingType,
            strategyStatus: StrategyStatus.success)));
  }

  Future<void> updateClientStrategy(
      int clientId, Map<String, dynamic> body) async {
    emit(state.copyWith(strategyUpdateStatus: StrategyStatus.loading));
    final response = await clientStrategyService.updateClientStrategy(
        clientId: clientId, body: body);
    emit(response.fold(
        (l) => state.copyWith(
            strategyUpdateStatus: StrategyStatus.error, message: l.message),
        (strategy) => state.copyWith(
            clientStrategy: strategy,
            currentTrainingType: strategy.trainingType,
            message: "",
            strategyUpdateStatus: StrategyStatus.success)));
  }
}
