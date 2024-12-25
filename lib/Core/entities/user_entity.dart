import 'package:equatable/equatable.dart';

import '../../data/models/city_model.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? email;
  final String? fullname;
  final String? image;
  final CityModel? city;
  final String? postalCode;
  final String? address;
  final String? phone;
  final String? role;
  final String? status;

  const UserEntity(
      {this.id,
      this.status,
      this.role,
      this.email,
      this.fullname,
      this.image,
      this.city,
      this.postalCode,
      this.address,
      this.phone});

  @override
  List<Object?> get props => [
        id,
        role,
        email,
        fullname,
        image,
        city,
        postalCode,
        address,
        phone,
        status
      ];
}
