part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final LoginStatus? loginStatus;
  final String? errorMessage;
  const LoginState(
      {this.loginStatus = LoginStatus.initial, this.errorMessage = ""});

  LoginState copyWith({LoginStatus? loginStatus, String? errorMessage}) {
    return LoginState(
        loginStatus: loginStatus ?? this.loginStatus,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [loginStatus!, errorMessage!];
}
