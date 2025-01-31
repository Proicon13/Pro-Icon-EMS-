import 'package:pro_icon/data/models/category_model.dart';

import '../../Core/entities/program_entity.dart';

class ProgramModelToEntityMapper {
  static ProgramEntity mapFromProgramModel(ProgramModel model) {
    if (model.cycles == null || model.programMuscles == null) {
      return ProgramEntity(
        id: model.id!,
        name: model.name!,
        description: model.description!,
        duration: model.duration!,
        image: model.image!,
        createdById: model.createdById!,
        pulse: model.pulse!,
        hertez: model.hertez!,
        stimulation: model.stimulation!,
        pauseInterval: model.pauseInterval!,
        contraction: model.contraction!,
      );
    } else {
      return CustomProgramEntity(
        id: model.id!,
        name: model.name!,
        description: model.description!,
        duration: model.duration!,
        image: model.image!,
        createdById: model.createdById!,
        pulse: model.pulse!,
        hertez: model.hertez!,
        stimulation: model.stimulation!,
        pauseInterval: model.pauseInterval!,
        contraction: model.contraction!,
        categoryId: model.categoryId ?? 0,
        programMuscles: model.programMuscles ?? [],
        cycles: model.cycles ?? [],
      );
    }
  }

  static ProgramModel toModel(ProgramEntity programEntity) {
    return ProgramModel(
      id: programEntity.id,
      name: programEntity.name,
      description: programEntity.description,
      duration: programEntity.duration,
      image: programEntity.image,
      createdById: programEntity.createdById,
      pulse: programEntity.pulse,
      hertez: programEntity.hertez,
    );
  }
}
