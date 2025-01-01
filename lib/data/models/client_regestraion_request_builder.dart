import 'client_registration.dart';

class ClientRegistrationBuilder {
  String? email;
  String? fullname;
  String? phone;
  String? address;
  String? postalCode;
  String? cityId;
  String? gender;
  int? weight;
  int? height;
  DateTime? birthDate;

  ClientRegistrationBuilder._();
  static final ClientRegistrationBuilder _instance =
      ClientRegistrationBuilder._();
  factory ClientRegistrationBuilder() => _instance;

  // Setters for fluent building
  ClientRegistrationBuilder setEmail(String? email) {
    this.email = email;
    return this;
  }

  ClientRegistrationBuilder setFullname(String? fullname) {
    this.fullname = fullname;
    return this;
  }

  ClientRegistrationBuilder setPhone(String? phone) {
    this.phone = phone;
    return this;
  }

  ClientRegistrationBuilder setAddress(String? address) {
    this.address = address;
    return this;
  }

  ClientRegistrationBuilder setPostalCode(String? postalCode) {
    this.postalCode = postalCode;
    return this;
  }

  ClientRegistrationBuilder setCityId(String? cityId) {
    this.cityId = cityId;
    return this;
  }

  ClientRegistrationBuilder setGender(String? gender) {
    this.gender = gender;
    return this;
  }

  ClientRegistrationBuilder setWeight(int? weight) {
    this.weight = weight;
    return this;
  }

  ClientRegistrationBuilder setHeight(int? height) {
    this.height = height;
    return this;
  }

  ClientRegistrationBuilder setBirthDate(DateTime? birthDate) {
    this.birthDate = birthDate;
    return this;
  }

  ClientRegistration build() {
    return ClientRegistration(
      email: email,
      fullname: fullname,
      phone: phone,
      address: address,
      postalCode: postalCode,
      cityId: cityId,
      gender: gender,
      weight: weight,
      height: height,
      birthDate: birthDate,
    );
  }

  void reset() {
    email = null;
    fullname = null;
    phone = null;
    address = null;
    postalCode = null;
    cityId = null;
    gender = null;
    weight = null;
    height = null;
    birthDate = null;
  }
}
