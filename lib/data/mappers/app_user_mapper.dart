import '../../Core/entities/user_entity.dart';
import '../models/app_user_model.dart';

class AppUserEntityMapper {
  static UserEntity toEntity(AppUserModel model) {
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
    );
  }
}
