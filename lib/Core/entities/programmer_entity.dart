import 'user_entity.dart';

class ProgrammerEntity extends UserEntity {
  ProgrammerEntity({
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
          role: "PROGRAMMER",
          email: email,
          fullname: fullname,
          image: image,
          city: city,
          postalCode: postalCode,
          address: address,
          phone: phone,
          status: status,
        );
}
