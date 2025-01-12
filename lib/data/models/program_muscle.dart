import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/muscle.dart';

class ProgramMuscle extends Equatable {
  final int? id;
  final Muscle? muscle;
  final bool? isActive;
  final num? pulse;

  const ProgramMuscle({
    this.id,
    this.muscle,
    this.isActive,
    this.pulse,
  });

  factory ProgramMuscle.fromJson(Map<String, dynamic> json) => ProgramMuscle(
        id: json['id'] ?? 0,
        muscle: json['muscle'] == null ? null : Muscle.fromJson(json['muscle']),
        isActive: json['isActive'] ?? true,
        pulse: json['pulse'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'muscle': muscle?.toJson(),
        'isActive': isActive,
        'pulse': pulse
      };

  ProgramMuscle copyWith({
    int? id,
    Muscle? muscle,
    bool? isActive,
    num? pulse,
  }) =>
      ProgramMuscle(
        id: id ?? this.id,
        muscle: muscle ?? this.muscle,
        isActive: isActive ?? this.isActive,
        pulse: pulse ?? this.pulse,
      );
  @override
  List<Object?> get props => [id, muscle, isActive, pulse];
}
