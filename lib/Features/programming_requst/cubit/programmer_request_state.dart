part of 'programmer_request_cubit.dart';

enum ProgrammerRequestStatus { initial, loading, success, error }

extension ProgrammerRequestStateX on ProgrammerRequestState {
  bool get isCheckLoading =>
      this.checkStatus == ProgrammerRequestStatus.loading;
  bool get isCheckSuccess =>
      this.checkStatus == ProgrammerRequestStatus.success;
  bool get isCheckError => this.checkStatus == ProgrammerRequestStatus.error;

  bool get isApplyLoading =>
      this.applyStatus == ProgrammerRequestStatus.loading;
  bool get isApplySuccess =>
      this.applyStatus == ProgrammerRequestStatus.success;
  bool get isApplyError => this.applyStatus == ProgrammerRequestStatus.error;
}

class ProgrammerRequestState extends Equatable {
  final ProgrammerRequestStatus? checkStatus;
  final ProgrammerRequestStatus? applyStatus;
  final String? message;

  const ProgrammerRequestState({
    this.checkStatus = ProgrammerRequestStatus.initial,
    this.applyStatus = ProgrammerRequestStatus.initial,
    this.message = '',
  });

  ProgrammerRequestState copyWith({
    ProgrammerRequestStatus? checkStatus,
    ProgrammerRequestStatus? applyStatus,
    String? message,
  }) =>
      ProgrammerRequestState(
        checkStatus: checkStatus ?? this.checkStatus,
        applyStatus: applyStatus ?? this.applyStatus,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [checkStatus, applyStatus, message];
}
