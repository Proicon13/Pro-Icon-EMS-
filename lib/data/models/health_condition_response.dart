import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/health_condition.dart';

class HealthConditionResponse extends Equatable {
  final List<Injury> injuries;
  final List<Disease> diseases;

  HealthConditionResponse({required this.injuries, required this.diseases});

  factory HealthConditionResponse.fromJson(Map<String, dynamic> json) =>
      HealthConditionResponse(
          injuries: (json['injuries'] as List<dynamic>)
              .map((json) => Injury.fromJson(json))
              .toList(),
          diseases: (json['diseases'] as List<dynamic>)
              .map((json) => Disease.fromJson(json))
              .toList());
  @override
  List<Object?> get props => [injuries, diseases];
}
