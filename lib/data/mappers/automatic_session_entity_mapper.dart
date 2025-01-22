import 'package:pro_icon/Core/entities/automatic_session_entity.dart';
import 'package:pro_icon/data/models/auto_session_model.dart';

class AutomaticSessionEntityMapper {
  static AutomaticSessionEntity fromModel(AutoSessionModel model) {
    switch (model.type) {
      case 'CUSTOM':
        return CustomAutomaticSessionEntity(
            id: model.id,
            name: model.name,
            duration: model.duration,
            createdById: model.createdById,
            sessionPrograms: model.sessionPrograms);
      case 'AUTOMATIC':
        return MainAutomaticSessionEntity(
            id: model.id,
            name: model.name,
            duration: model.duration,
            createdById: model.createdById,
            sessionPrograms: model.sessionPrograms,
            image: model.image);
      default:
        return AutomaticSessionEntity(
            id: model.id,
            name: model.name,
            duration: model.duration,
            createdById: model.createdById,
            sessionPrograms: model.sessionPrograms);
    }
  }
}
