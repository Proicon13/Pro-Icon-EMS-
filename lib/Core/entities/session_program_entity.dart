import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';

class SessionProgramEntity extends Equatable {
  final int id;
  final int duration;
  final int pulse;
  final int order;
  final ProgramEntity program;

  SessionProgramEntity(
      {required this.id,
      this.duration = 0,
      this.pulse = 0,
      this.order = 1,
      required this.program});

  SessionProgramEntity copyWith({
    int? id,
    int? duration,
    int? pulse,
    int? order,
    ProgramEntity? program,
  }) =>
      SessionProgramEntity(
          id: id ?? this.id,
          duration: duration ?? this.duration,
          pulse: pulse ?? this.pulse,
          order: order ?? this.order,
          program: program ?? this.program);
  @override
  List<Object?> get props => [id, duration, pulse, order, program];
}
