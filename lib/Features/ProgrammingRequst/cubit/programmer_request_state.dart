part of 'programmer_request_cubit.dart';

@immutable
sealed class ProgrammerRequestState {}

final class ProgrammerRequestInitial extends ProgrammerRequestState {}

class ProgrammerRequestLoaded extends ProgrammerRequestState {

  final ProgrammingRequest programmingRequest;

  ProgrammerRequestLoaded(this.programmingRequest);

}


class ProgrammerRequestError extends ProgrammerRequestState {
  final String errorMessage;

  ProgrammerRequestError(this.errorMessage);
}
