part of 'set_new_password_cubit.dart';

enum SetNewPasswordStatus { initial, submitting, success, error }

class SetNewPasswordState extends Equatable {
  final SetNewPasswordStatus? status;
  final String? responseMessage;
  const SetNewPasswordState(
      {this.status = SetNewPasswordStatus.initial, this.responseMessage = ""});

  SetNewPasswordState copyWith({
    SetNewPasswordStatus? status,
    String? responseMessage,
  }) {
    return SetNewPasswordState(
      status: status ?? this.status,
      responseMessage: responseMessage ?? this.responseMessage,
    );
  }

  @override
  List<Object> get props => [status!, responseMessage!];
}
