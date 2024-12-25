import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/data/services/clients_service.dart';
import 'package:pro_icon/data/services/trainer_service.dart';

import '../../../Core/utils/enums/filteration_type.dart';

part 'user_managment_state.dart';

class UserManagmentCubit extends Cubit<UserManagmentState> {
  final TrainerService trainerService;
  final ClientsService clientsService;

  UserManagmentCubit(
      {required this.trainerService, required this.clientsService})
      : super(const UserManagmentState()) {
    getTrainers(); // Trigger once when the Cubit is created
  }

  Timer? _debounce;

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  bool _canPerformAction() {
    // prevent action if request is loading
    return state.requestStatus != RequestStatus.loading;
  }

  Future<void> getTrainers() async {
    final currentPage = state.currentTrainersPage;
    // if not first load then show loading indicator when call
    if (currentPage! > 1)
      emit(state.copyWith(requestStatus: RequestStatus.loading));
    final response = await trainerService.getTrainers(page: currentPage);
    response.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message,
            requestStatus: RequestStatus.error)), (trainers) {
      emit(state.copyWith(
          trainers: trainers,
          errorMessage: "",
          currentTrainersPage: currentPage + 1,
          requestStatus: RequestStatus.loaded));
    });
  }

  Future<void> getClients() async {
    final currentPage = state.currentClientsPage;
    // if not first load then show loading indicator when call
    if (currentPage! > 1)
      emit(state.copyWith(requestStatus: RequestStatus.loading));
    final response = await clientsService.getClients(page: currentPage);
    response.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message,
            requestStatus: RequestStatus.error)), (clients) {
      emit(state.copyWith(
          clients: clients,
          errorMessage: "",
          currentClientsPage: currentPage + 1,
          requestStatus: RequestStatus.loaded));
    });
  }

  Future<void> _searchClientByNameOrEmail(String query) async {
    if (!_canPerformAction()) return;
    emit(state.copyWith(
        requestStatus: RequestStatus.loading)); // trigger loading
    final response =
        await clientsService.searchClientByNameOrEmail(query: query);
    response.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message,
            requestStatus: RequestStatus.error)), (clients) {
      emit(state.copyWith(
          searchList: clients,
          errorMessage: "",
          requestStatus: RequestStatus.loaded));
    });
  }

  Future<void> onSearch(String query) async {
    if (!_canPerformAction()) return;

    toggleIsSearching(true);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () async {
      final currentVariation =
          state.currentVariation; // get current variation (trainers or clients)
      if (currentVariation == UserVariations.trainer && query.isNotEmpty) {
        await _searchTrainerByNameOrEmail(query); // search for trainers
      }
      if (currentVariation == UserVariations.client && query.isNotEmpty) {
        await _searchClientByNameOrEmail(query); // search for clients
      }
    });
  }

  Future<void> _filterTrainers(FilterationType filterBy) async {
    if (!_canPerformAction()) return;

    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final response = await trainerService.filterTrainers(filterBy: filterBy);
    response.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message,
            requestStatus: RequestStatus.error)), (trainers) {
      emit(state.copyWith(
          trainers: trainers,
          errorMessage: "",
          requestStatus: RequestStatus.loaded));
    });
  }

  Future<void> _filterClients(FilterationType filterBy) async {
    if (!_canPerformAction()) return;

    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final response = await clientsService.filterClients(filterBy: filterBy);
    response.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message,
            requestStatus: RequestStatus.error)), (clients) {
      emit(state.copyWith(
          clients: clients,
          errorMessage: "",
          requestStatus: RequestStatus.loaded));
    });
  }

  Future<void> onFilter(FilterationType filterBy) async {
    if (state.currentVariation == UserVariations.trainer) {
      await _filterTrainers(filterBy);
    } else if (state.currentVariation == UserVariations.client) {
      await _filterClients(filterBy);
    }
  }

  Future<void> _searchTrainerByNameOrEmail(String query) async {
    emit(state.copyWith(
        requestStatus: RequestStatus.loading)); // trigger loading
    final response =
        await trainerService.searchTrainerByNameOrEmail(query: query);
    response.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message,
            requestStatus: RequestStatus.error)), (trainers) {
      emit(state.copyWith(
          searchList: trainers,
          errorMessage: "",
          requestStatus: RequestStatus.loaded));
    });
  }

  void toggleIsSearching(bool isSearching) {
    final currentMode = state.isSearching;
    if (!_canPerformAction()) return;

    if (currentMode == isSearching) return;

    emit(state.copyWith(isSearching: isSearching));
  }

  void toggleVariation(UserVariations variation) {
    if (!_canPerformAction()) return;

    emit(state.copyWith(currentVariation: variation));
  }
}
