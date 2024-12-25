import 'package:equatable/equatable.dart';

import '../../data/models/city_model.dart';
import 'user_entity.dart';

class ClientEntity extends UserEntity {
  final String? gender;
  final String? startDate;
  final String? endDate;
  final Supervisor? superVisor;

  ClientEntity({
    this.gender,
    this.startDate,
    this.endDate,
    this.superVisor,
    int? id,
    String? role,
    String? email,
    String? fullname,
    String? image,
    CityModel? city,
    String? postalCode,
    String? address,
    String? phone,
    String? status,
  }) : super(
          id: id,
          role: role,
          email: email,
          fullname: fullname,
          image: image,
          city: city,
          status: status,
          postalCode: postalCode,
          address: address,
          phone: phone,
        );

  @override
  List<Object?> get props =>
      super.props + [gender, startDate, endDate, superVisor];
}

class Supervisor extends Equatable {
  final int? id;
  final String? email;
  final String? fullname;

  Supervisor({this.id, this.email, this.fullname});

  @override
  List<Object?> get props => [id, email, fullname];
}
