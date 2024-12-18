import 'package:equatable/equatable.dart';

import 'city_model.dart';

class AppUserModel extends Equatable {
  final int id;
  final String email;
  final String fullname;
  final String image;
  final CityModel city;
  final String postalCode;
  final String address;
  final String phone;
  final String role;
  final String? status;

  const AppUserModel({
    this.status,
    required this.id,
    required this.email,
    required this.fullname,
    required this.image,
    required this.city,
    required this.postalCode,
    required this.address,
    required this.phone,
    required this.role,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      fullname: json['fullname'] as String,
      image: json['image'] != null ? json['image'] as String : '',
      city: CityModel.fromJson(json['city'] as Map<String, dynamic>),
      postalCode: json['postalCode'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      status: json['status'] != null ? json['status'] as String : 'NOT ACTIVE',
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        fullname,
        image,
        city,
        postalCode,
        address,
        phone,
        role,
        status
      ];
}
