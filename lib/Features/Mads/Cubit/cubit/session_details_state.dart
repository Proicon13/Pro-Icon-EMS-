part of 'session_details_cubit.dart';

enum SessionDetailsRequestStatus { intial, loading, success, error }

extension SessionDetailsStateX on SessionDetailsState {
  bool get isLoading =>
      this.requestStatus == SessionDetailsRequestStatus.loading;
  bool get isSuccess =>
      this.requestStatus == SessionDetailsRequestStatus.success;
  bool get isError => this.requestStatus == SessionDetailsRequestStatus.error;
}

class SessionDetailsState extends Equatable {
  final int? madId;
  final SessionDetailsRequestStatus? requestStatus;
  final int? currentPage;
  final int? totalPages;
  final String? message;
  final List<MadSessionEntity>? sessions;

  const SessionDetailsState(
      {this.requestStatus = SessionDetailsRequestStatus.loading,
      this.currentPage = 1,
      this.totalPages = 1,
      this.message = '',
      this.madId = -1,
      this.sessions = const []});

  SessionDetailsState copyWith(
          {SessionDetailsRequestStatus? requestStatus,
          int? currentPage,
          int? totalPages,
          String? message,
          int? madId,
          List<MadSessionEntity>? sessions}) =>
      SessionDetailsState(
          requestStatus: requestStatus ?? this.requestStatus,
          currentPage: currentPage ?? this.currentPage,
          totalPages: totalPages ?? this.totalPages,
          message: message ?? this.message,
          sessions: sessions ?? this.sessions,
          madId: madId ?? this.madId);

  @override
  List<Object> get props =>
      [requestStatus!, currentPage!, totalPages!, message!, sessions!, madId!];
}
