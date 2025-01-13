import 'package:pro_icon/data/models/category_model.dart';
import 'package:pro_icon/data/models/cycle.dart';
import 'package:pro_icon/data/models/program_muscle.dart';

class CustomProgramModel extends ProgramModel {
  final int? categoryId;
  final int? stimulation;
  final int? pauseInterval;
  final int? contraction;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProgramMuscle>? programMuscles;
  final List<Cycle>? cycles;

  const CustomProgramModel({
    int? id,
    String? name,
    String? description,
    int? duration,
    String? image,
    int? createdById,
    int? pulse,
    int? hertez,
    this.categoryId,
    this.stimulation,
    this.pauseInterval,
    this.contraction,
    this.createdAt,
    this.updatedAt,
    this.programMuscles,
    this.cycles,
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
  factory CustomProgramModel.fromJson(Map<String, dynamic> json) {
    return CustomProgramModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Default Program",
      description: json['description'] ?? "",
      duration: json['duration'] ?? 20,
      image: json['image'] ?? "",
      createdById: json['createdById'] ?? 0,
      pulse: json['pulse'] ?? 0,
      hertez: json['hertez'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      stimulation: json['stimulation'] ?? '',
      pauseInterval: json['pauseInterval'] ?? 0,
      contraction: json['contraction'] ?? 0,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      programMuscles: json['programMuscles'] != null
          ? (json['programMuscles'] as List)
              .map((item) => ProgramMuscle.fromJson(item))
              .toList()
          : null,
      cycles: json['cycles'] != null
          ? (json['cycles'] as List)
              .map((item) => Cycle.fromJson(item))
              .toList()
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['categoryId'] = categoryId;
    data['stimulation'] = stimulation;
    data['pauseInterval'] = pauseInterval;
    data['contraction'] = contraction;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    if (programMuscles != null) {
      data['programMuscles'] =
          programMuscles!.map((item) => item.toJson()).toList();
    }
    if (cycles != null) {
      data['cycles'] = cycles!.map((item) => item.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        ...super.props,
        categoryId,
        stimulation,
        pauseInterval,
        contraction,
        createdAt,
        updatedAt,
        programMuscles,
        cycles,
        pulse,
        hertez,
      ];
}
