import 'package:equatable/equatable.dart';

import '../../../data/models/mad.dart';

enum MadsRequestStatus { intial, loading, success, error }

class MadsState extends Equatable {
  final List<Mad>? madsList;
  final String? message;
  final MadsRequestStatus? status;
  final MadsRequestStatus? changeStatus;

  const MadsState({
    this.changeStatus = MadsRequestStatus.intial,
    this.madsList = const [],
    this.message = "",
    this.status = MadsRequestStatus.loading,
  });

  MadsState copyWith({
    List<Mad>? madsList,
    String? message,
    MadsRequestStatus? status,
    MadsRequestStatus? changeStatus,
  }) {
    return MadsState(
      changeStatus: changeStatus ?? this.changeStatus,
      madsList: madsList ?? this.madsList,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [madsList, message, status, changeStatus];
}
