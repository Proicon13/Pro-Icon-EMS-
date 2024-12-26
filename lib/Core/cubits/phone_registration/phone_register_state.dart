part of 'phone_register_cubit.dart';

class PhoneRegistrationState extends Equatable {
  final String? phoneCode;
  final String? errorMessage;
  const PhoneRegistrationState(
      {this.phoneCode = "+20", this.errorMessage = ""});

  PhoneRegistrationState copyWith({String? phoneCode, String? errorMessage}) =>
      PhoneRegistrationState(
          phoneCode: phoneCode ?? this.phoneCode,
          errorMessage: errorMessage ?? this.errorMessage);

  @override
  List<Object> get props => [phoneCode!, errorMessage!];
}
