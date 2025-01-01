import 'package:equatable/equatable.dart';

class ClientRegistration extends Equatable {
  final String? email;
  final String? fullname;
  final String? phone;
  final String? address;
  final String? postalCode;
  final String? cityId;
  final String? gender;
  final num? weight;
  final num? height;
  final DateTime? birthDate;

  ClientRegistration(
      {this.email,
      this.fullname,
      this.phone,
      this.address,
      this.postalCode,
      this.cityId,
      this.gender,
      this.weight,
      this.height,
      this.birthDate});
  @override
  List<Object?> get props => [
        email,
        fullname,
        phone,
        address,
        postalCode,
        cityId,
        gender,
        weight,
        height,
        birthDate
      ];
}
