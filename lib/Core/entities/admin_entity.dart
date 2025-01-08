import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/data/models/programming_request.dart';

class AdminEntity extends UserEntity {
  final ProgrammingRequest? programmingRequest;
  AdminEntity(
      {id,
      email,
      fullname,
      image,
      city,
      postalCode,
      address,
      phone,
      status,
      this.programmingRequest})
      : super(
          id: id,
          role: "ADMIN",
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
