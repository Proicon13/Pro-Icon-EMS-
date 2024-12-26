part of 'manage_trainer_cubit.dart';

enum ManageTrainerStatus { intial, loading, success, error }

class ManageTrainerState extends Equatable {
  final ManageTrainerStatus? requestStataus;
  final String? message;
  const ManageTrainerState(
      {this.requestStataus = ManageTrainerStatus.intial, this.message = ""});

  ManageTrainerState copyWith({
    ManageTrainerStatus? requestStataus,
    String? message,
  }) {
    return ManageTrainerState(
      requestStataus: requestStataus ?? this.requestStataus,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [requestStataus!, message!];
}
