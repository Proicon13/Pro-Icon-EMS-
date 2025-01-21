import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Core/entities/automatic_session_entity.dart';
import '../../../data/services/auto_session_service.dart';
import 'main_auto_session_cubit.dart';

part 'custom_auto_session_state.dart';

class CustomAutoSessionCubit extends Cubit<CustomAutoSessionState> {
  final AutoSessionService autoSessionService;

  CustomAutoSessionCubit({required this.autoSessionService})
      : super(const CustomAutoSessionState());

  Future<void> fetchCustomSessions({bool isFirstFetch = false}) async {
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
      type: "CUSTOM",
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
