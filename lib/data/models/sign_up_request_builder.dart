import 'sign_up_request.dart';

class SignupRequestBuilder {
  String? _email;
  String? _fullname;
  String? _phone;
  String? _address;
  String? _postalCode;
  String? _cityId;
  String? _password;
  String? _role;

  SignupRequestBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  SignupRequestBuilder setFullname(String fullname) {
    _fullname = fullname;
    return this;
  }

  SignupRequestBuilder setPhone(String phone) {
    _phone = phone;
    return this;
  }

  SignupRequestBuilder setAddress(String address) {
    _address = address;
    return this;
  }

  SignupRequestBuilder setPostalCode(String postalCode) {
    _postalCode = postalCode;
    return this;
  }

  SignupRequestBuilder setCityId(String cityId) {
    _cityId = cityId;
    return this;
  }

  SignupRequestBuilder setPassword(String password) {
    _password = password;
    return this;
  }

  SignupRequestBuilder setRole(String role) {
    _role = role;
    return this;
  }

  SignupRequest build() {
    if (_email == null ||
        _fullname == null ||
        _phone == null ||
        _address == null ||
        _postalCode == null ||
        _cityId == null ||
        _password == null) {
      throw Exception("All fields must be set before building the request");
    }
    return SignupRequest(
      email: _email!,
      fullname: _fullname!,
      phone: _phone!,
      address: _address!,
      postalCode: _postalCode!,
      cityId: _cityId!,
      password: _password!,
      role: _role!,
    );
  }

  @override
  String toString() {
    return "SignupRequestBuilder{email: $_email, fullname: $_fullname, phone: $_phone, address: $_address, postalCode: $_postalCode, cityId: $_cityId, password: $_password, role: $_role}";
  }
}
