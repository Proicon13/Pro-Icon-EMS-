import 'app_user_model.dart';
import 'city_model.dart';

class ClientModel extends AppUserModel {
  final String? gender;
  final DateTime? startDate;
  final DateTime? endDate;
  final SupervisorModel? user;

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
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      postalCode: json['postalCode']?.toString(),
      image: json['image'] as String?,
      status: json['status'] as String?,
      city: json['city'] != null
          ? CityModel.fromJson(json['city'] as Map<String, dynamic>)
          : null,
      gender: json['gender'] as String?,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      user: json['user'] != null
          ? SupervisorModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
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
