import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/cycle.dart';

import 'program_muscle.dart';

class CategoryModel {
  int? id;
  String? name;
  String? description;
  String? image;
  List<ProgramModel>? programs;

  CategoryModel(
      {this.id, this.name, this.description, this.image, this.programs});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "Category";
    description = json['description'] ?? "";
    image = json['image'] ?? "";
    if (json['programs'] != null) {
      programs = <ProgramModel>[];
      (json['programs'] as List<dynamic>).forEach((v) {
        programs!.add(new ProgramModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    if (this.programs != null) {
      data['programs'] = this.programs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProgramModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final int? duration;
  final String? image;
  final int? createdById;
  final int? pulse;
  final int? hertez;
  final int? categoryId;
  final int? stimulation;
  final int? pauseInterval;
  final num? contraction;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProgramMuscle>? programMuscles;
  final List<Cycle>? cycles;

  const ProgramModel({
    this.id,
    this.name,
    this.description,
    this.duration,
    this.image,
    this.createdById,
    this.pulse,
    this.hertez,
    this.categoryId,
    this.stimulation,
    this.pauseInterval,
    this.contraction,
    this.createdAt,
    this.updatedAt,
    this.programMuscles = const [],
    this.cycles = const [],
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? "Not Defined",
      description: json['description'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      image: json['image'] as String? ?? '',
      createdById: json['createdById'] as int? ?? 0,
      pulse: json['pulse'] as int? ?? 0,
      hertez: json['hertez'] as int? ?? 0,
      categoryId: json['categoryId'] as int?,
      stimulation: json['stimulation'] as int? ?? 0,
      pauseInterval: json['pauseInterval'] as int? ?? 0,
      contraction: json['contraction'] as num? ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      programMuscles: json['programMuscles'] == null
          ? null
          : (json['programMuscles'] as List)
              .map((e) => ProgramMuscle.fromJson(e as Map<String, dynamic>))
              .toList(),
      cycles: json['cycles'] == null
          ? null
          : (json['cycles'] as List)
              .map((e) => Cycle.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['duration'] = duration;
    data['image'] = image;
    data['createdById'] = createdById;
    data['pulse'] = pulse;
    data['hertez'] = hertez;
    data['categoryId'] = categoryId;
    data['stimulation'] = stimulation;
    data['pauseInterval'] = pauseInterval;
    data['contraction'] = contraction;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['programMuscles'] = programMuscles != null
        ? programMuscles!.map((e) => e.toJson()).toList()
        : [];
    data['cycles'] =
        cycles != null ? cycles!.map((e) => e.toJson()).toList() : [];
    return data;
  }

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
        categoryId,
        stimulation,
        pauseInterval,
        contraction,
        createdAt,
        updatedAt,
        programMuscles,
        cycles,
      ];
}
