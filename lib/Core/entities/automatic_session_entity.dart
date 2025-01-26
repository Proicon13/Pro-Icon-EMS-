import 'package:equatable/equatable.dart';

import '../../data/models/auto_session_model.dart';

class AutomaticSessionEntity extends Equatable {
  final int? id;
  final String? name;

  final int? duration;
  final int? createdById;
  final String? type;
  final List<SessionProgram>? sessionPrograms;

  const AutomaticSessionEntity(
      {this.id,
      this.name,
      this.duration,
      this.createdById,
      this.type,
      this.sessionPrograms});
  @override
  List<Object?> get props => [
        id,
        name,
        duration,
        createdById,
        type,
        sessionPrograms,
      ];
}

class CustomAutomaticSessionEntity extends AutomaticSessionEntity {
  CustomAutomaticSessionEntity({
    int? id,
    String? name,
    int? duration,
    int? createdById,
    List<SessionProgram>? sessionPrograms,
  }) : super(
            id: id,
            name: name,
            duration: duration,
            createdById: createdById,
            type: "CUSTOM",
            sessionPrograms: sessionPrograms);
}

class MainAutomaticSessionEntity extends AutomaticSessionEntity {
  final String? image;
  MainAutomaticSessionEntity({
    this.image,
    int? id,
    String? name,
    int? duration,
    int? createdById,
    List<SessionProgram>? sessionPrograms,
  }) : super(
            id: id,
            name: name,
            duration: duration,
            createdById: createdById,
            type: "MAIN",
            sessionPrograms: sessionPrograms);

  @override
  List<Object?> get props => [
        ...super.props,
        image,
      ];
}
