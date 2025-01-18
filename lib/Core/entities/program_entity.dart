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

  const ProgramEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.image,
    required this.createdById,
    required this.pulse,
    required this.hertez,
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
      ];
}

class CustomProgramEntity extends ProgramEntity {
  final int categoryId;
  final int stimulation;
  final int pauseInterval;
  final double contraction;
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
    required this.categoryId,
    required this.stimulation,
    required this.pauseInterval,
    required this.contraction,
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
    int? categoryId,
    int? stimulation,
    int? pauseInterval,
    double? contraction,
    List<ProgramMuscle>? programMuscles,
    List<Cycle>? cycles,
  }) =>
      CustomProgramEntity(
          id: id ?? this.id,
          name: name ?? this.name,
          description: description ?? this.description,
          duration: duration ?? this.duration,
          image: image ?? this.image,
          createdById: createdById ?? this.createdById,
          pulse: pulse ?? this.pulse,
          hertez: hertez ?? this.hertez,
          categoryId: categoryId ?? this.categoryId,
          stimulation: stimulation ?? this.stimulation,
          pauseInterval: pauseInterval ?? this.pauseInterval,
          contraction: contraction ?? this.contraction,
          programMuscles: programMuscles ?? this.programMuscles,
          cycles: cycles ?? this.cycles);

  @override
  List<Object?> get props => [
        ...super.props,
        categoryId,
        stimulation,
        pauseInterval,
        contraction,
        programMuscles,
        cycles,
      ];
}
