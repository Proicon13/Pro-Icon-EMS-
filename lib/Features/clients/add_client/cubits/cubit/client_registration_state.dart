part of 'client_registration_cubit.dart';

enum RequestStatus { loading, success, error }

class ClientRegistrationState extends Equatable {
  final RequestStatus? requestStatus;
  final String? message;
  const ClientRegistrationState(
      {this.requestStatus = RequestStatus.loading, this.message = ""});

  ClientRegistrationState copyWith({
    RequestStatus? requestStatus,
    String? message,
  }) {
    return ClientRegistrationState(
      requestStatus: requestStatus ?? this.requestStatus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [requestStatus!, message!];
}
