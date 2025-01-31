import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/mad.dart';

import 'category_model.dart';
import 'city_model.dart';
import 'programming_request.dart';

class AppUserModel extends Equatable {
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
  final ProgrammingRequest? promotionRequest;
  final List<ProgramModel>? customPrograms;
  final List<Mad>? mads;

  const AppUserModel({
    this.id,
    this.email,
    this.fullname,
    this.image,
    this.city,
    this.postalCode,
    this.address,
    this.phone,
    this.role,
    this.status,
    this.promotionRequest,
    this.customPrograms,
    this.mads,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      id: json['id'] != null ? json['id'] as int : null,
      email: json['email'] != null ? json['email'] as String : null,
      fullname: json['fullname'] != null ? json['fullname'] as String : null,
      image: json['image'] != null ? json['image'] as String : "",
      city: json['city'] != null
          ? CityModel.fromJson(json['city'] as Map<String, dynamic>)
          : null,
      postalCode: json['postalCode'] != null
          ? json['postalCode'] as String
          : "No Postal Code",
      address:
          json['address'] != null ? json['address'] as String : "No Address",
      phone: json['phone'] != null ? json['phone'] as String : "No Phone",
      role: json['role'] != null ? json['role'] as String : null,
      status: json['status'] != null ? json['status'] as String : "NOT ACTIVE",
      customPrograms: json['programs'] != null
          ? (json['programs'] as List)
              .map((e) => ProgramModel.fromJson(e))
              .toList()
          : [],
      mads: json['mads'] != null
          ? (json['mads'] as List).map((e) => Mad.fromJson(e)).toList()
          : [],
      promotionRequest: json['promotionRequest'] != null
          ? ProgrammingRequest.fromJson(
              json['promotionRequest'] as Map<String, dynamic>)
          : null,
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
        status,
        promotionRequest,
        customPrograms,
        mads
      ];
}
