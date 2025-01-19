part of 'trainer_password_cubit.dart';

enum RequestStatus { intial, submitting, success, error }

class TrainerPasswordState extends Equatable {
  final RequestStatus? status;
  final String? message;

  const TrainerPasswordState(
      {this.status = RequestStatus.intial, this.message = ""});

  TrainerPasswordState copyWith({
    RequestStatus? status,
    String? message,
  }) =>
      TrainerPasswordState(
          status: status ?? this.status, message: message ?? this.message);

  @override
  List<Object> get props => [status!, message!];
}
