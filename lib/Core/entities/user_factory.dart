import 'package:pro_icon/Core/entities/user_entity.dart';

import 'admin_entity.dart';
import 'programmer_entity.dart';
import 'trainer_entity.dart';

class UserFactory {
  UserFactory._();
  static UserEntity getUserType(String role) {
    switch (role) {
      case 'ADMIN':
        return AdminEntity();
      case 'TRAINER':
        return TrainerEntity();
      case 'PROGRAMMER':
        return ProgrammerEntity();
      default:
        return const UserEntity();
    }
  }
}
