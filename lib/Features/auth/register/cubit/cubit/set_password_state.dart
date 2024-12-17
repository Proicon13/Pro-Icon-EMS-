part of 'set_password_cubit.dart';

enum SetPasswordStatus { intial, submitting, success, error }

class SetPasswordState extends Equatable {
  final SetPasswordStatus? status;
  final String? errorMessage;
  const SetPasswordState({
    this.status = SetPasswordStatus.intial,
    this.errorMessage = "",
  });

  SetPasswordState copyWith(
          {SetPasswordStatus? status, String? errorMessage}) =>
      SetPasswordState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
  @override
  List<Object> get props => [status!, errorMessage!];
}
