import 'package:pro_icon/data/models/category_model.dart';

import '../../Core/entities/program_entity.dart';
import '../models/custom_program_model.dart';

class ProgramModelToEntityMapper {
  static ProgramEntity mapProgramModelToEntity(ProgramModel programModel) {
    return ProgramEntity(
      id: programModel.id ?? 0,
      name: programModel.name ?? "Default Program",
      description: programModel.description ?? "",
      duration: programModel.duration ?? 20,
      image: programModel.image ?? "",
      createdById: programModel.createdById ?? 0,
      pulse: programModel.pulse ?? 0,
      hertez: programModel.hertez ?? 0,
    );
  }

  static ProgramEntity mapCustomProgramModelToEntity(
      CustomProgramModel customProgramModel) {
    return CustomProgramEntity(
      id: customProgramModel.id ?? 0,
      name: customProgramModel.name ?? "Default Program",
      description: customProgramModel.description ?? "",
      duration: customProgramModel.duration ?? 20,
      image: customProgramModel.image ?? "",
      createdById: customProgramModel.createdById ?? 0,
      pulse: customProgramModel.pulse ?? 0,
      hertez: customProgramModel.hertez ?? 0,
      categoryId: customProgramModel.categoryId ?? 0,
      stimulation: customProgramModel.stimulation ?? 0,
      pauseInterval: customProgramModel.pauseInterval ?? 0,
      contraction: customProgramModel.contraction ?? 0,
      programMuscles: customProgramModel.programMuscles ?? [],
      cycles: customProgramModel.cycles ?? [],
    );
  }
}
