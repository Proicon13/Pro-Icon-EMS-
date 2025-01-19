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
    mads,
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
            mads: mads);

  ProgrammerEntity copyWith({
    List<ProgramEntity>? customPrograms,
  }) {
    return ProgrammerEntity(
      id: this.id,
      email: this.email,
      fullname: this.fullname,
      image: this.image,
      city: this.city,
      postalCode: this.postalCode,
      address: this.address,
      status: this.status,
      phone: this.phone,
      customPrograms: customPrograms ?? this.customPrograms,
    );
  }

  @override
  List<Object?> get props => [...super.props, customPrograms, role];
}
