import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/services/clients_service.dart';
import '../../entities/user_entity.dart';
import '../../utils/enums/filteration_type.dart';

part 'client_managment_state.dart';

class ClientManagementCubit extends Cubit<ClientManagementState> {
  final ClientsService clientsService;
  Timer? _debounce;

  ClientManagementCubit({required this.clientsService})
      : super(const ClientManagementState()) {}

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  Future<void> getClients({bool resetPagination = false}) async {
    // Use state extension for pagination check

    final page = resetPagination ? 1 : state.currentPage;

    emit(state.copyWith(
      isPaginationLoading: page > 1,
      requestStatus: page == 1 ? RequestStatus.loading : state.requestStatus,
      clients: resetPagination ? [] : state.clients, // Reset list if needed
      currentPage: page,
    ));

    final response = await clientsService.getClients(page: page);

    response.fold(
      (failure) => emit(state.copyWith(
        message: failure.message,
        requestStatus: RequestStatus.error,
        isPaginationLoading: false,
      )),
      (clientsResponse) {
        final List<UserEntity> updatedClients = List<UserEntity>.from(
            state.clients)
          ..addAll(
              clientsResponse.data); // Create a new list before adding new data
        emit(state.copyWith(
          clients: page == 1 ? clientsResponse.data : updatedClients,
          message: "",
          totalPages: clientsResponse.totalPages,
          currentPage: page + 1,
          isPaginationLoading: false,
          requestStatus: RequestStatus.loaded,
        ));
      },
    );
  }

  /// **Handles Searching Clients with Debouncing**
  void handleSearch(String query) {
    if (state.requestStatus == RequestStatus.loading) return;

    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 800), () async {
      if (query.isEmpty) {
        emit(state.copyWith(searchList: []));
      } else {
        await searchClientByNameOrEmail(query);
      }
    });
  }

  /// **Performs Client Search**
  Future<void> searchClientByNameOrEmail(String query) async {
    if (state.requestStatus == RequestStatus.loading) return;

    emit(state.copyWith(
      requestStatus: RequestStatus.loading,
      isSearching: true,
      searchList: [], // Clear previous search results
    ));

    final response =
        await clientsService.searchClientByNameOrEmail(query: query);

    response.fold(
      (failure) => emit(state.copyWith(
        message: failure.message,
        requestStatus: RequestStatus.error,
      )),
      (clients) => emit(state.copyWith(
        searchList: List.from(clients.data),
        message: "",
        requestStatus: RequestStatus.loaded,
      )),
    );
  }

  /// **Filters Clients Based on Criteria**
  Future<void> filterClients(FilterationType filterBy) async {
    if (state.requestStatus == RequestStatus.loading) return;

    emit(state.copyWith(
      requestStatus: RequestStatus.loading,
      isSearching: false,
      currentPage: 1, // Reset to first page when filtering
    ));

    final response = await clientsService.filterClients(
      filterBy: filterBy,
      page: 1, // Always reset pagination when filtering
    );

    response.fold(
      (failure) => emit(state.copyWith(
        message: failure.message,
        requestStatus: RequestStatus.error,
      )),
      (clients) => emit(state.copyWith(
        clients: List.from(clients.data),
        message: "",
        totalPages: clients.totalPages,
        requestStatus: RequestStatus.loaded,
      )),
    );
  }

  /// **Deletes a Client**
  Future<void> deleteClient(UserEntity client) async {
    // if (state.requestStatus == RequestStatus.loading) return;

    // emit(state.copyWith(requestStatus: RequestStatus.loading));

    // final response = await clientsService.deleteClient(id: client.id);

    // response.fold(
    //   (failure) => emit(state.copyWith(
    //     requestStatus: RequestStatus.error,
    //     message: failure.message,
    //   )),
    //   (successMessage) => emit(state.copyWith(
    //     message: successMessage,
    //     clients: List.from(state.clients)..remove(client),
    //     requestStatus: RequestStatus.loaded,
    //   )),
    // );
  }

  void toggleSearch(bool isSearching) {
    if (state.isSearching == isSearching) return;
    emit(state.copyWith(isSearching: isSearching));
  }
}
