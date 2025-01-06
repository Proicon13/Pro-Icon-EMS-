part of 'strategy_cubit.dart';

enum StrategyStatus { intial, loading, success, error }

class StrategyState extends Equatable {
  final StrategyStatus strategyStatus;
  final StrategyStatus strategyUpdateStatus;
  final String? message;
  final TrainingTypes? currentTrainingType;
  final ClientStrategy? clientStrategy;
  final bool? isTrainingTypesopen;
  final bool? isTargetSectionOpen;
  const StrategyState(
      {this.strategyStatus = StrategyStatus.loading,
      this.strategyUpdateStatus = StrategyStatus.intial,
      this.message = "",
      this.isTargetSectionOpen = true,
      this.isTrainingTypesopen = true,
      this.currentTrainingType = TrainingTypes.staticTraining,
      this.clientStrategy = const ClientStrategy()});

  StrategyState copyWith(
      {StrategyStatus? strategyStatus,
      StrategyStatus? strategyUpdateStatus,
      String? message,
      ClientStrategy? clientStrategy,
      TrainingTypes? currentTrainingType,
      bool? isTrainingTypesopen,
      bool? isTargetSectionOpen}) {
    return StrategyState(
      strategyStatus: strategyStatus ?? this.strategyStatus,
      strategyUpdateStatus: strategyUpdateStatus ?? this.strategyUpdateStatus,
      message: message ?? this.message,
      isTrainingTypesopen: isTrainingTypesopen ?? this.isTrainingTypesopen,
      isTargetSectionOpen: isTargetSectionOpen ?? this.isTargetSectionOpen,
      currentTrainingType: currentTrainingType ?? this.currentTrainingType,
      clientStrategy: clientStrategy ?? this.clientStrategy,
    );
  }

  @override
  List<Object> get props => [
        strategyStatus,
        strategyUpdateStatus,
        message!,
        clientStrategy!,
        currentTrainingType!,
        isTrainingTypesopen!,
        isTargetSectionOpen!,
      ];
}
