import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/cycle.dart';

class AddCustomProgramModel {
  final int? id;
  final String? name;
  final String? description;
  final int? duration;
  final String? image;

  final int? pulse;
  final int? hertez;
  final int? categoryId;
  final int? stimulation;
  final int? pauseInterval;
  final int? contraction;

  final List<AddProgramMuscleModel>? programMuscles;
  final List<AddCycleModel>? cycles;

  AddCustomProgramModel(
      {this.id,
      this.name,
      this.description,
      this.duration,
      this.image,
      this.pulse,
      this.hertez,
      this.categoryId,
      this.stimulation,
      this.pauseInterval,
      this.contraction,
      this.programMuscles,
      this.cycles});

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'description': this.description ?? "",
        'duration': this.duration,
        'file': this.image,
        'pulse': this.pulse,
        'hertez': this.hertez,
        'stimulation': this.stimulation,
        'pauseInterval': this.pauseInterval,
        'contraction': this.contraction,
        'programMuscles':
            this.programMuscles!.map((item) => item.toJson()).toList(),
        'cycles': this.cycles!.map((item) => item.toJson()).toList(),
      };
}

class AddProgramMuscleModel extends Equatable {
  final int? muscleId;
  final num? value;
  final bool? isActive;

  AddProgramMuscleModel(
      {this.muscleId = 0, this.value = 0, this.isActive = true});

  factory AddProgramMuscleModel.fromJson(Map<String, dynamic> json) =>
      AddProgramMuscleModel(
        muscleId: json['id'],
        value: json['value'],
        isActive: json['isActive'],
      );

  AddProgramMuscleModel copyWith({
    int? muscleId,
    num? value,
    bool? isActive,
  }) =>
      AddProgramMuscleModel(
        muscleId: muscleId ?? this.muscleId,
        value: value ?? this.value,
        isActive: isActive ?? this.isActive,
      );

  Map<String, dynamic> toJson() => {
        'id': this.muscleId,
        'value': this.value,
        'isActive': this.isActive,
      };

  @override
  List<Object?> get props => [muscleId, value, isActive];
}

class AddCycleModel extends Equatable {
  final int? frequency;
  final num? value;
  AddCycleModel({this.frequency, this.value});
  factory AddCycleModel.fromJson(Map<String, dynamic> json) => AddCycleModel(
        frequency: json['frequancy'],
        value: json['value'],
      );

  factory AddCycleModel.fromCycle(Cycle cycle) => AddCycleModel(
      frequency: cycle.frequency!.toInt(), value: cycle.adjustment);
  Map<String, dynamic> toJson() => {'frequancy': frequency, 'value': value};
  @override
  List<Object?> get props => [frequency, value];
}
