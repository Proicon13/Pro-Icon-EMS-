import 'package:pro_icon/Core/entities/category_entity.dart';
import 'package:pro_icon/data/mappers/program_entity_mapper.dart';
import 'package:pro_icon/data/models/category_model.dart';

class CategoryModelToEntityMapper {
  static CategoryEntity toEntity(CategoryModel model) {
    return CategoryEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      image: model.image,
      programs: model.programs!
          .map((element) =>
              ProgramModelToEntityMapper.mapProgramModelToEntity(element))
          .toList(),
    );
  }
}
