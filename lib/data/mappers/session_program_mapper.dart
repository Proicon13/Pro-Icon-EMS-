import 'package:pro_icon/Core/entities/session_program_entity.dart';
import 'package:pro_icon/data/mappers/program_entity_mapper.dart';

import '../models/auto_session_model.dart';

class SessionProgramMapper {
  static SessionProgramEntity fromModel(SessionProgram model) {
    return SessionProgramEntity(
      id: model.id!,
      duration: model.duration!,
      pulse: model.pulse!,
      order: model.order!,
      program: ProgramModelToEntityMapper.mapFromProgramModel(model.program!),
    );
  }

  static SessionProgram toModel(SessionProgramEntity entity) {
    return SessionProgram(
      id: entity.id,
      duration: entity.duration,
      pulse: entity.pulse,
      order: entity.order,
      program: ProgramModelToEntityMapper.toModel(entity.program),
    );
  }
}
