import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/data/models/programming_request.dart';

class AdminEntity extends UserEntity {
  final ProgrammingRequest? programmingRequest;
  const AdminEntity(
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

  AdminEntity copyWith({ProgrammingRequest? programmingRequest}) => AdminEntity(
      id: this.id,
      email: this.email,
      fullname: this.fullname,
      image: this.image,
      city: this.city,
      postalCode: this.postalCode,
      address: this.address,
      phone: this.phone,
      status: this.status,
      programmingRequest: programmingRequest ?? this.programmingRequest);

  @override
  List<Object?> get props => super.props + [programmingRequest, role];
}
