import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final String accessToken;

  const LoginResponseModel({required this.accessToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
    );
  }

  @override
  List<Object?> get props => [accessToken];
}
