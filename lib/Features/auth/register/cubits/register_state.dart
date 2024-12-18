part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final String? phoneCode;
  final String? errorMessage;
  const RegisterState({this.phoneCode = "+20", this.errorMessage = ""});

  RegisterState copyWith({String? phoneCode, String? errorMessage}) =>
      RegisterState(
          phoneCode: phoneCode ?? this.phoneCode,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props => [phoneCode!, errorMessage!];
}
