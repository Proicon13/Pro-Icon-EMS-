import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/category_model.dart';

class AutoSessionModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;
  final int? duration;
  final int? createdById;
  final String? type;
  final List<SessionProgram>? sessionPrograms;

  const AutoSessionModel({
    this.id,
    this.name,
    this.image,
    this.duration,
    this.createdById,
    this.type,
    this.sessionPrograms,
  });

  factory AutoSessionModel.fromJson(Map<String, dynamic> json) {
    return AutoSessionModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? "Default Name",
      image: json['image'] ?? '',
      duration: json['duration'] ?? 25,
      createdById: json['createdById'] ?? -1,
      type: json['type'] ?? 'MAIN',
      sessionPrograms: (json['sessionPrograms'] as List<dynamic>?)
              ?.map((e) => SessionProgram.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'duration': duration,
      'sessionPrograms': sessionPrograms?.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props =>
      [id, name, image, duration, createdById, type, sessionPrograms];
}

class SessionProgram extends Equatable {
  final int? id;
  final int? duration;
  final int? pulse;
  final int? order;
  final ProgramModel? program;

  const SessionProgram(
      {this.duration, this.pulse, this.order, this.program, this.id});

  factory SessionProgram.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SessionProgram();

    return SessionProgram(
      id: json['order'] as int?,
      duration: json['duration'] as int?,
      pulse: json['pulse'] as int?,
      order: json['order'] as int?,
      program: json['program'] != null
          ? ProgramModel.fromJson(json['program'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "programId": program?.id,
      "duration": duration,
      "pulse": pulse,
      "order": order
    };
  }

  SessionProgram copyWith({
    int? id,
    int? duration,
    int? pulse,
    int? order,
    ProgramModel? program,
  }) {
    return SessionProgram(
      id: id ?? this.id,
      duration: duration ?? this.duration,
      pulse: pulse ?? this.pulse,
      order: order ?? this.order,
      program: program ?? this.program,
    );
  }

  @override
  List<Object?> get props => [duration, pulse, order, program];
}
