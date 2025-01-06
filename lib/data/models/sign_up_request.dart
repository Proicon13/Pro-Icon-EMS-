class SignupRequest {
  final String email;
  final String fullname;
  final String phone;
  final String address;
  final String postalCode;
  final String cityId;
  final String password;
  final String role;

  SignupRequest._({
    required this.email,
    required this.fullname,
    required this.phone,
    required this.address,
    required this.postalCode,
    required this.cityId,
    required this.password,
    required this.role,
  });

  factory SignupRequest({
    required String email,
    required String fullname,
    required String phone,
    required String address,
    required String postalCode,
    required String cityId,
    required String password,
    required String role,
  }) {
    return SignupRequest._(
      email: email,
      fullname: fullname,
      phone: phone,
      address: address,
      postalCode: postalCode,
      cityId: cityId,
      password: password,
      role: role,
    );
  }

  /// Converts the SignupRequest object to a JSON-compatible Map
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "fullname": fullname,
      "phone": phone,
      "address": address,
      "postalCode": postalCode,
      "cityId": cityId,
      "password": password,
      "role": role,
    };
  }

  @override
  String toString() {
    return '''
SignupRequest {
  email: $email,
  fullname: $fullname,
  phone: $phone,
  address: $address,
  postalCode: $postalCode,
  cityId: $cityId,
  password: $password,
  role: $role
}''';
  }
}
