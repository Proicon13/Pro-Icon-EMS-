part of 'mads_cubit.dart';

enum MadsRequestStatus { intial, loading, success, error }

class MadsState extends Equatable {
  final List<Mad>? madsList;
  final String? message;
  final MadsRequestStatus? status;

  const MadsState({
    this.madsList = const [],
    this.message = "",
    this.status = MadsRequestStatus.loading,
  });

  MadsState copyWith({
    List<Mad>? madsList,
    String? message,
    MadsRequestStatus? status,
  }) {
    return MadsState(
      madsList: madsList ?? this.madsList,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [madsList, message, status];
}
