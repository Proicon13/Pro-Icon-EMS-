class UpdateResponseModel {
  final String? fullname;
  final String? address;
  final String? postalCode;
  final String? phone;
  final String? gender;
  final String? status;
  final String? cityId;
  final DateTime? startDate;
  final DateTime? endDate;

  UpdateResponseModel({
    this.fullname,
    this.address,
    this.postalCode,
    this.phone,
    this.gender,
    this.status,
    this.cityId,
    this.startDate,
    this.endDate,
  });

  factory UpdateResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateResponseModel(
      fullname: json['fullname'] ?? 'Unknown Name',
      address: json['address'] ?? 'No Address Provided',
      postalCode: json['postalCode'] ?? '00000',
      phone: json['phone'] ?? 'No Phone',
      gender: json['gender'] ?? 'UNKNOWN',
      status: json['status'] ?? 'NOT ACTIVE',
      cityId: json['cityId'] ?? 'Unknown City',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : DateTime.now(),
    );
  }
}
