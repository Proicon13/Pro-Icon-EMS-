import 'package:pro_icon/Core/entities/user_entity.dart';

class AdminEntity extends UserEntity {
  AdminEntity({
    id,
    role,
    email,
    fullname,
    image,
    city,
    postalCode,
    address,
    phone,
  }) : super(
          id: id,
          role: role,
          email: email,
          fullname: fullname,
          image: image,
          city: city,
          postalCode: postalCode,
          address: address,
          phone: phone,
        );
}
