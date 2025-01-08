import 'package:pro_icon/Core/entities/user_entity.dart';

class TrainerEntity extends UserEntity {
  TrainerEntity({
    id,
    email,
    fullname,
    image,
    city,
    postalCode,
    address,
    status,
    phone,
  }) : super(
            id: id,
            role: "TRAINER",
            email: email,
            fullname: fullname,
            image: image,
            city: city,
            postalCode: postalCode,
            address: address,
            phone: phone,
            status: status);
}
