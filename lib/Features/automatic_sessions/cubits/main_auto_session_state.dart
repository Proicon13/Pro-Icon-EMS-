part of 'main_auto_session_cubit.dart';

enum AutoSessionsRequestStatus { initial, loading, loaded, error }

extension MainAutoSessionStateExtension on MainAutoSessionState {
  bool get canLoadMore => currentPage! < totalPages!;
  bool get isLoading => status == AutoSessionsRequestStatus.loading;
  bool get isInitial => status == AutoSessionsRequestStatus.initial;
  bool get isLoaded => status == AutoSessionsRequestStatus.loaded;
  bool get isError => status == AutoSessionsRequestStatus.error;
}

class MainAutoSessionState extends Equatable {
  final AutoSessionsRequestStatus? status;
  final List<MainAutomaticSessionEntity>? sessions;
  final int? currentPage;
  final int? totalPages;
  final String? message;
  final bool? firstTimeFetch;
  const MainAutoSessionState(
      {this.status = AutoSessionsRequestStatus.loading,
      this.sessions = const [],
      this.currentPage = 1,
      this.totalPages = 1,
      this.message = "",
      this.firstTimeFetch = true});

  MainAutoSessionState copyWith({
    AutoSessionsRequestStatus? status,
    List<MainAutomaticSessionEntity>? sessions,
    int? currentPage,
    int? totalPages,
    String? message,
    bool? firstTimeFetch,
  }) {
    return MainAutoSessionState(
      status: status ?? this.status,
      sessions: sessions ?? this.sessions,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      message: message ?? this.message,
      firstTimeFetch: firstTimeFetch ?? this.firstTimeFetch,
    );
  }

  @override
  List<Object> get props => [
        status!,
        sessions!,
        currentPage!,
        totalPages!,
        message!,
        firstTimeFetch!
      ];
}
