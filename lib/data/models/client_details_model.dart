import 'city_model.dart';
import 'client_model.dart';

class ClientDetailsModel extends ClientModel {
  final bool? isDeleted;
  final bool? isBlocked;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClientDetailsModel({
    this.isDeleted,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    int? id,
    String? fullname,
    String? email,
    String? phone,
    String? address,
    String? postalCode,
    String? image,
    String? status,
    String? gender,
    DateTime? startDate,
    DateTime? endDate,
    CityModel? city,
    SupervisorModel? user,
  }) : super(
          id: id,
          fullname: fullname,
          email: email,
          phone: phone,
          address: address,
          postalCode: postalCode,
          image: image,
          status: status,
          gender: gender,
          startDate: startDate,
          endDate: endDate,
          city: city,
          user: user,
        );

  factory ClientDetailsModel.fromJson(Map<String, dynamic> json) {
    return ClientDetailsModel(
      isDeleted: json['isDeleted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      id: json['id'] as int?,
      fullname: json['fullname'] ?? 'Unknown Name',
      email: json['email'] ?? 'Unknown Email',
      phone: json['phone'] ?? 'No Phone',
      address: json['address'] ?? 'No Address Provided',
      postalCode: json['postalCode']?.toString() ?? '00000',
      image: json['image'] ?? '',
      status: json['status'] ?? 'NOT ACTIVE',
      gender: json['gender'] ?? 'Unknown',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      city: json['city'] != null
          ? CityModel.fromJson(json['city'] as Map<String, dynamic>)
          : null,
      user: json['user'] != null
          ? SupervisorModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'isDeleted': isDeleted,
      'isBlocked': isBlocked,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    });
    return json;
  }
}
