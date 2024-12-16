import 'package:equatable/equatable.dart';

class ResetPasswordRequest extends Equatable {
  final String email;
  final String resetCode;
  final String newPassword;

  const ResetPasswordRequest({
    required this.email,
    required this.resetCode,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "resetCode": resetCode,
      "newPassword": newPassword,
    };
  }

  @override
  String toString() {
    return '''
ResetPasswordRequest {
  email: $email,
  resetCode: $resetCode,
  newPassword: $newPassword
}''';
  }

  @override
  List<Object?> get props => [email, resetCode, newPassword];
}
