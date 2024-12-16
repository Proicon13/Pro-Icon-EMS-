import 'reset_password_request.dart';

class ResetPasswordRequestBuilder {
  static final ResetPasswordRequestBuilder _instance =
      ResetPasswordRequestBuilder._internal();

  ResetPasswordRequestBuilder._internal();

  factory ResetPasswordRequestBuilder() {
    return _instance;
  }

  String? _email;
  String? _resetCode;
  String? _newPassword;

  // Set Email
  ResetPasswordRequestBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  // Set Reset Code
  ResetPasswordRequestBuilder setResetCode(String resetCode) {
    _resetCode = resetCode;
    return this;
  }

  // Set New Password
  ResetPasswordRequestBuilder setNewPassword(String newPassword) {
    _newPassword = newPassword;
    return this;
  }

  ResetPasswordRequest build() {
    return ResetPasswordRequest(
      email: _email!,
      resetCode: _resetCode!,
      newPassword: _newPassword!,
    );
  }

  // Reset Builder State
  void reset() {
    _email = null;
    _resetCode = null;
    _newPassword = null;
  }

  @override
  String toString() {
    return '''
ResetPasswordRequestBuilder {
  email: $_email,
  resetCode: $_resetCode,
  newPassword: $_newPassword
}''';
  }
}
