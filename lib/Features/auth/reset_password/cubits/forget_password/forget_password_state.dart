part of 'forget_password_cubit.dart';

enum CodeRequestStatus { initial, submitting, success, error }

class ForgetPasswordState extends Equatable {
  final CodeRequestStatus? codeRequestStatus;
  final String? codeStatusMessage;
  const ForgetPasswordState(
      {this.codeRequestStatus = CodeRequestStatus.initial,
      this.codeStatusMessage = ""});

  ForgetPasswordState copyWith({
    CodeRequestStatus? codeRequestStatus,
    String? codeStatusMessage,
  }) {
    return ForgetPasswordState(
      codeRequestStatus: codeRequestStatus ?? this.codeRequestStatus,
      codeStatusMessage: codeStatusMessage ?? this.codeStatusMessage,
    );
  }

  @override
  List<Object> get props => [codeRequestStatus!, codeStatusMessage!];
}
