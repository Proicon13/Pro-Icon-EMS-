import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/services/auto_session_service.dart';

import '../../../Core/entities/automatic_session_entity.dart';

part 'main_auto_session_state.dart';

class MainAutoSessionCubit extends Cubit<MainAutoSessionState> {
  final AutoSessionService autoSessionService;

  MainAutoSessionCubit({required this.autoSessionService})
      : super(const MainAutoSessionState());

  /// Public method to fetch sessions
  Future<void> fetchMainSessions({bool isFirstFetch = false}) async {
    if (isFirstFetch) {
      await _firstFetch();
    } else {
      await _fetchNextPage();
    }
  }

  /// Handle first-time fetch
  Future<void> _firstFetch() async {
    if (!(state.firstTimeFetch ?? false)) return;

    emit(state.copyWith(status: AutoSessionsRequestStatus.loading));

    final result = await autoSessionService.getAutomaticSessions(
      type: "AUTOMATIC",
      page: 1,
    );

    result.fold(
      (failure) => _emitError(failure.message),
      (sessions) => emit(state.copyWith(
        status: AutoSessionsRequestStatus.loaded,
        sessions: sessions.data,
        currentPage: 1,
        totalPages: sessions.totalPages,
        firstTimeFetch: false,
        message: "",
      )),
    );
  }

  /// Handle pagination
  Future<void> _fetchNextPage() async {
    if (!state.canLoadMore) return;

    emit(state.copyWith(status: AutoSessionsRequestStatus.loading));

    final result = await autoSessionService.getAutomaticSessions(
      type: "AUTOMATIC",
      page: (state.currentPage ?? 1) + 1,
    );

    result.fold(
      (failure) => _emitError(failure.message),
      (sessions) => emit(state.copyWith(
        status: AutoSessionsRequestStatus.loaded,
        sessions: [...state.sessions ?? [], ...sessions.data],
        currentPage: state.currentPage! + 1,
        totalPages: sessions.totalPages,
        message: "",
      )),
    );
  }

  /// Handle errors
  void _emitError(String message) {
    emit(state.copyWith(
      status: AutoSessionsRequestStatus.error,
      message: message,
    ));
  }
}
