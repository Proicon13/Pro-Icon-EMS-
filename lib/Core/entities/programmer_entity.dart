import 'package:pro_icon/Core/entities/program_entity.dart';

import 'user_entity.dart';

class ProgrammerEntity extends UserEntity {
  final List<ProgramEntity>? customPrograms;
  const ProgrammerEntity({
    id,
    email,
    fullname,
    image,
    city,
    postalCode,
    address,
    status,
    phone,
    this.customPrograms,
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
