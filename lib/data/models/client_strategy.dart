import 'package:equatable/equatable.dart';

import '../../Core/utils/enums/training_types.dart';

class ClientStrategy extends Equatable {
  final num? targetWeight;
  final num? musclesMass;
  final num? bodyFatMass;
  final TrainingTypes? trainingType;

  const ClientStrategy({
    this.targetWeight,
    this.musclesMass,
    this.bodyFatMass,
    this.trainingType = TrainingTypes.staticTraining,
  });

  factory ClientStrategy.fromJson(Map<String, dynamic> json) {
    return ClientStrategy(
      targetWeight: json['targetWeight'] ?? 0,
      musclesMass: json['muclesMass'] ?? 0,
      bodyFatMass: json['boudyFatMass'] ?? 0,
      trainingType: trainingTypesMap[json['trainingType']] ??
          TrainingTypes.staticTraining,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetWeight': targetWeight.toString(),
      'muclesMass': musclesMass.toString(),
      'boudyFatMass': bodyFatMass.toString(),
      'trainingType': trainingType!.jsonName,
    };
  }

  @override
  List<Object?> get props =>
      [targetWeight, musclesMass, bodyFatMass, trainingType];
}
