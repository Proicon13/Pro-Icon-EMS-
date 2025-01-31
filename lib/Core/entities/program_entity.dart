import 'package:equatable/equatable.dart';

import '../../data/models/cycle.dart';
import '../../data/models/program_muscle.dart';

class ProgramEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int duration;
  final String image;
  final int createdById;
  final int pulse;
  final int hertez;
  final int stimulation;
  final int pauseInterval;
  final num contraction;

  const ProgramEntity({
    required this.id,
    this.name = "",
    this.description = "",
    this.duration = 0,
    this.image = "",
    this.createdById = 0,
    this.pulse = 0,
    this.hertez = 0,
    this.stimulation = 0,
    this.pauseInterval = 0,
    this.contraction = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        duration,
        image,
        createdById,
        pulse,
        hertez,
        stimulation,
        pauseInterval,
        contraction,
      ];
}

class CustomProgramEntity extends ProgramEntity {
  final int categoryId;
  final List<ProgramMuscle> programMuscles;
  final List<Cycle> cycles;

  const CustomProgramEntity({
    required int id,
    required String name,
    required String description,
    required int duration,
    required String image,
    required int createdById,
    required int pulse,
    required int hertez,
    required int stimulation,
    required int pauseInterval,
    required num contraction,
    required this.categoryId,
    required this.programMuscles,
    required this.cycles,
  }) : super(
          id: id,
          name: name,
          description: description,
          duration: duration,
          image: image,
          createdById: createdById,
          pulse: pulse,
          hertez: hertez,
          stimulation: stimulation,
          pauseInterval: pauseInterval,
          contraction: contraction,
        );

  CustomProgramEntity copyWith({
    int? id,
    String? name,
    String? description,
    int? duration,
    String? image,
    int? createdById,
    int? pulse,
    int? hertez,
    int? stimulation,
    int? pauseInterval,
    num? contraction,
    int? categoryId,
    List<ProgramMuscle>? programMuscles,
    List<Cycle>? cycles,
  }) {
    return CustomProgramEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      image: image ?? this.image,
      createdById: createdById ?? this.createdById,
      pulse: pulse ?? this.pulse,
      hertez: hertez ?? this.hertez,
      stimulation: stimulation ?? this.stimulation,
      pauseInterval: pauseInterval ?? this.pauseInterval,
      contraction: contraction ?? this.contraction,
      categoryId: categoryId ?? this.categoryId,
      programMuscles: programMuscles ?? this.programMuscles,
      cycles: cycles ?? this.cycles,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        categoryId,
        programMuscles,
        cycles,
      ];
}
