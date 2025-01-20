import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/mad_session_entity.dart';
import 'package:pro_icon/Core/networking/api_constants.dart';
import 'package:pro_icon/data/services/mad_sessions_service.dart';

part 'session_details_state.dart';

class SessionDetailsCubit extends Cubit<SessionDetailsState> {
  final MadSessionsService service;

  SessionDetailsCubit({required this.service})
      : super(const SessionDetailsState());

  void setMadId(int madId) => emit(state.copyWith(madId: madId));

  void fetchMadSessions({DateTime? from, DateTime? to}) async {
    // If from and to filters are applied, fetch all data
    if (from != null || to != null) {
      _fetchAllFilteredSessions(from: from, to: to);
    } else {
      _fetchPaginatedSessions();
    }
  }

  Future<void> _fetchAllFilteredSessions({DateTime? from, DateTime? to}) async {
    final madId = state.madId;
    if (madId == null) {
      emit(state.copyWith(
        requestStatus: SessionDetailsRequestStatus.error,
        message: "MAD ID is not set",
      ));
      return;
    }

    emit(state.copyWith(requestStatus: SessionDetailsRequestStatus.loading));

    final response = await service.getMadsSession(
      madId: madId,
      page: 1, // Always fetch from the first page
      perPage:
          state.currentPage! * ApiConstants.defaultPerPage, // Fetch all data
      fromDate: from?.toIso8601String().split('T')[0],
      toDate: to?.toIso8601String().split('T')[0],
    );

    response.fold(
      (failure) {
        emit(state.copyWith(
          requestStatus: SessionDetailsRequestStatus.error,
          message: failure.message,
        ));
      },
      (sessions) {
        emit(state.copyWith(
          requestStatus: SessionDetailsRequestStatus.success,
          sessions: sessions.data,
          message: "",
        ));
      },
    );
  }

  Future<void> _fetchPaginatedSessions() async {
    if (state.currentPage! > state.totalPages!) return;

    final madId = state.madId;
    if (madId == null) {
      emit(state.copyWith(
        requestStatus: SessionDetailsRequestStatus.error,
        message: "MAD ID is not set",
      ));
      return;
    }

    emit(state.copyWith(requestStatus: SessionDetailsRequestStatus.loading));

    final response = await service.getMadsSession(
      madId: madId,
      page: state.currentPage,
      perPage: null, // Default perPage value (handled by the service)
      fromDate: null,
      toDate: null,
    );

    response.fold(
      (failure) {
        emit(state.copyWith(
          requestStatus: SessionDetailsRequestStatus.error,
          message: failure.message,
        ));
      },
      (sessions) {
        emit(state.copyWith(
          requestStatus: SessionDetailsRequestStatus.success,
          sessions: [...state.sessions!, ...sessions.data],
          currentPage: state.currentPage! + 1,
          totalPages: sessions.totalPages,
          message: "",
        ));
      },
    );
  }
}
