import 'package:pro_icon/data/mappers/program_entity_mapper.dart';

import '../../Core/entities/admin_entity.dart';
import '../../Core/entities/programmer_entity.dart';
import '../../Core/entities/trainer_entity.dart';
import '../../Core/entities/user_entity.dart';
import '../models/app_user_model.dart';

class AppUserEntityMapper {
  static UserEntity toEntity(AppUserModel model) {
    switch (model.role) {
      case 'ADMIN':
        return AdminEntity(
          id: model.id,
          email: model.email,
          fullname: model.fullname,
          image: model.image,
          city: model.city,
          postalCode: model.postalCode,
          address: model.address,
          phone: model.phone,
          status: model.status,
          programmingRequest: model.promotionRequest,
        );
      case 'TRAINER':
        return TrainerEntity(
          id: model.id,
          email: model.email,
          fullname: model.fullname,
          image: model.image,
          city: model.city,
          postalCode: model.postalCode,
          address: model.address,
          phone: model.phone,
          status: model.status,
        );
      case 'PROGRAMMER':
        return ProgrammerEntity(
          id: model.id,
          email: model.email,
          fullname: model.fullname,
          image: model.image,
          city: model.city,
          postalCode: model.postalCode,
          address: model.address,
          phone: model.phone,
          status: model.status,
          customPrograms: model.customPrograms != null
              ? []
              : model.customPrograms!
                  .map((element) =>
                      ProgramModelToEntityMapper.mapCustomProgramModelToEntity(
                          element))
                  .toList(),
        );
      default:
        return UserEntity(
          id: model.id,
          email: model.email,
          fullname: model.fullname,
          image: model.image,
          city: model.city,
          postalCode: model.postalCode,
          address: model.address,
          phone: model.phone,
          role: model.role,
          status: model.status,
        );
    }
  }
}
