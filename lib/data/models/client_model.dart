import 'app_user_model.dart';
import 'city_model.dart';
import 'country_model.dart';

class ClientModel extends AppUserModel {
  final String? gender;
  final DateTime? startDate;
  final DateTime? endDate;
  final num? weight;
  final num? height;
  final DateTime? birthDate;
  final SupervisorModel? user;
  final String? medicalNotes;

  const ClientModel({
    int? id,
    String? fullname,
    String? email,
    String? phone,
    String? address,
    String? postalCode,
    String? image,
    String? status,
    String? role,
    CityModel? city,
    this.gender,
    this.startDate,
    this.endDate,
    this.user,
    this.weight,
    this.height,
    this.birthDate,
    this.medicalNotes,
  }) : super(
          id: id,
          fullname: fullname,
          email: email,
          phone: phone,
          address: address,
          postalCode: postalCode,
          image: image,
          status: status,
          city: city,
          role: role,
        );

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'] as int?,
      fullname: json['fullname'] ?? 'Unknown Name',
      email: json['email'] ?? 'Unknown Email',
      phone: json['phone'] ?? 'No Phone',
      address: json['address'] ?? 'No Address Provided',
      postalCode:
          json['postalCode'] != null ? json['postalCode'].toString() : '00000',
      image: json['image'] ?? '',
      status: json['status'] ?? 'NOT ACTIVE',
      gender: json['gender'] ?? 'Unknown',
      weight: json['weight'] as num?,
      height: json['height'] as num?,
      birthDate: json['birthdate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : DateTime.now(),
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : DateTime.now(),
      user: json['user'] != null
          ? SupervisorModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      medicalNotes: json['medicalNotes'] ?? '',
      city: json['city'] != null
          ? CityModel.fromJson(json['city'] as Map<String, dynamic>)
          : const CityModel(
              id: 0,
              name: 'Unknown City',
              country: CountryModel(name: "Unknown Country")),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'address': address,
      'postalCode': postalCode,
      'image': image,
      'status': status,
      'gender': gender,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'user': user?.toJson(),
      'city': city?.toJson(),
    };
  }
}

class SupervisorModel {
  final int? id;
  final String? fullname;
  final String? email;

  const SupervisorModel({this.id, this.fullname, this.email});

  factory SupervisorModel.fromJson(Map<String, dynamic> json) {
    return SupervisorModel(
      id: json['id'] as int?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
    };
  }
}
