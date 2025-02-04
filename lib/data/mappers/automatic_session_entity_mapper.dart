import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/data/models/auto_session_model.dart';

import 'session_program_mapper.dart';

class AutomaticSessionEntityMapper {
  static AutomaticSessionEntity fromModel(AutoSessionModel model) {
    switch (model.type) {
      case 'CUSTOM':
        return CustomAutomaticSessionEntity(
            id: model.id,
            name: model.name,
            duration: model.duration,
            createdById: model.createdById,
            sessionPrograms: model.sessionPrograms!
                .map((program) => SessionProgramMapper.fromModel(program))
                .toList());
      case 'AUTOMATIC':
        return MainAutomaticSessionEntity(
            id: model.id,
            name: model.name,
            duration: model.duration,
            createdById: model.createdById,
            sessionPrograms: model.sessionPrograms!
                .map((program) => SessionProgramMapper.fromModel(program))
                .toList(),
            image: model.image);
      default:
        return AutomaticSessionEntity(
            id: model.id,
            name: model.name,
            duration: model.duration,
            createdById: model.createdById,
            sessionPrograms: model.sessionPrograms!
                .map((program) => SessionProgramMapper.fromModel(program))
                .toList());
    }
  }
}
