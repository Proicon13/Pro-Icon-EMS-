import 'package:equatable/equatable.dart';

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
        'id': id,
        'name': name,
        'description': description,
        'duration': duration,
        'image': image,
        'pulse': pulse,
        'hertez': hertez,
        'categoryId': categoryId,
        'stimulation': stimulation,
        'pauseInterval': pauseInterval,
        'contraction': contraction,
        'programMuscles': programMuscles!.map((item) => item.toJson()).toList(),
        'cycles': cycles!.map((item) => item.toJson()).toList(),
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
        value: json['value'],
        isActive: json['isActive'],
      );

  Map<String, dynamic> toJson() => {
        'muscleId': muscleId,
        'value': value,
        'isActive': isActive,
      };

  @override
  List<Object?> get props => [muscleId, value, isActive];
}

class AddCycleModel extends Equatable {
  final int? frequency;
  final num? value;
  AddCycleModel({this.frequency, this.value});
  factory AddCycleModel.fromJson(Map<String, dynamic> json) => AddCycleModel(
        frequency: json['frequency'],
        value: json['value'],
      );
  Map<String, dynamic> toJson() => {'frequency': frequency, 'value': value};
  @override
  List<Object?> get props => [frequency, value];
}
