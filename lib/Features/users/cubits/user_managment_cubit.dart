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

  bool _canFetchMore() {
    final currentVariation = state.currentVariation;
    late int currentPage;
    if (currentVariation == UserVariations.trainer) {
      currentPage = state.currentTrainersPage!;
      if (state.totalTrainersPage == currentPage - 1)
        return false; // reached max pages can`t fetch more
    } else {
      currentPage = state.currentClientsPage!;
      if (state.totalClientsPage == currentPage - 1) return false;
    }
    return true;
  }

  Future<void> getTrainers() async {
    final currentPage = state.currentTrainersPage;
    // if not first load then show loading indicator when call
    if (!_canFetchMore()) return; // reatched max total pages don`t fetch

    if (currentPage! > 1)
      // show pagination loading
      emit(state.copyWith(isPaginationLoading: true));
    final response = await trainerService.getTrainers(page: currentPage);
    response.fold(
        (failure) => emit(state.copyWith(
            message: failure.message,
            isPaginationLoading: true,
            requestStatus: RequestStatus.error)), (trainers) {
      emit(state.copyWith(
          trainers: trainers.data.isEmpty
              ? List.from(state.trainers!)
              : List.from(state.trainers!)
            ..addAll(trainers.data),
          message: "",
          totalTrainersPage: trainers.totalPages,
          currentTrainersPage: currentPage + 1,
          isPaginationLoading: false,
          requestStatus: RequestStatus.loaded));
    });
  }

  Future<void> getClients() async {
    final currentPage = state.currentClientsPage;
    // if first call then show loading indicator
    if (!_canFetchMore()) return;
    if (currentPage! > 1)
      // show pagination loading
      emit(state.copyWith(isPaginationLoading: true));
    final response = await clientsService.getClients(page: currentPage);
    response.fold(
        (failure) => emit(state.copyWith(
            message: failure.message,
            requestStatus: RequestStatus.error)), (clients) {
      emit(state.copyWith(
          clients: clients.data.isEmpty
              ? List.from(state.clients!)
              : List.from(state.clients!)
            ..addAll(clients.data),
          message: "",
          totalClientsPage: clients.totalPages,
          currentClientsPage: currentPage + 1,
          isPaginationLoading: false,
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
            message: failure.message,
            requestStatus: RequestStatus.error)), (clients) {
      emit(state.copyWith(
          searchList: List.from(clients.data),
          message: "",
          requestStatus: RequestStatus.loaded));
    });
  }

  Future<void> onSearch(String query) async {
    // prevent action if request is loading
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
    final currentPage = state.currentTrainersPage;
    emit(state.copyWith(
        requestStatus: RequestStatus.loading, isSearching: false));
    final response = await trainerService.filterTrainers(
        filterBy: filterBy, page: currentPage! - 1);
    response.fold(
        (failure) => emit(state.copyWith(
            message: failure.message,
            requestStatus: RequestStatus.error)), (trainers) {
      emit(state.copyWith(
          trainers: List.from(trainers.data),
          message: "",
          requestStatus: RequestStatus.loaded));
    });
  }

  Future<void> _filterClients(FilterationType filterBy) async {
    final currentPage = state.currentClientsPage;
    emit(state.copyWith(
        requestStatus: RequestStatus.loading, isSearching: false));
    final response = await clientsService.filterClients(
        filterBy: filterBy, page: currentPage! - 1);
    response.fold(
        (failure) => emit(state.copyWith(
            message: failure.message,
            requestStatus: RequestStatus.error)), (clients) {
      emit(state.copyWith(
          clients: List.from(clients.data),
          message: "",
          requestStatus: RequestStatus.loaded));
    });
  }

  Future<void> onFilter(FilterationType filterBy) async {
    if (state.currentVariation == UserVariations.trainer) {
      await _filterTrainers(filterBy);
    } else {
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
            message: failure.message,
            requestStatus: RequestStatus.error)), (trainers) {
      emit(state.copyWith(
          searchList: List.from(trainers.data),
          message: "",
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
    if (!_canPerformAction()) return; // if loading don`t do anything
    if (variation == state.currentVariation)
      return; // if same selected don`t do anything
    emit(state.copyWith(
        currentVariation: variation, requestStatus: RequestStatus.loading));

    if (variation == UserVariations.trainer) {
      _handleOnTrainerVariation();
    } else {
      _handleOnClientVariation();
    }
  }

  void _handleOnTrainerVariation() {
    final currentTrainerPage = state.currentTrainersPage;
    // if not first load then don`t fetch
    if (currentTrainerPage != 1)
      // trigger state to load current trainers
      emit(state.copyWith(requestStatus: RequestStatus.loaded));
    else {
      // first time fetch trainers
      getTrainers();
    }
  }

  void _handleOnClientVariation() {
    final currentClientPage = state.currentClientsPage;
    // if not first load then don`t fetch
    if (currentClientPage != 1)
      // trigger state to load current clients
      emit(state.copyWith(requestStatus: RequestStatus.loaded));
    else {
      // first time fetch clients
      getClients();
    }
  }

  void onDelete(UserEntity user) {
    if (state.currentVariation == UserVariations.trainer) {
      _deleteTrainer(user);
    }
  }

  Future<void> _deleteTrainer(UserEntity trainer) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    final response = await trainerService.deleteTrainer(id: trainer.id!);
    response.fold(
        (failure) => emit(state.copyWith(
            requestStatus: RequestStatus.error, message: failure.message)),
        (message) => emit(state.copyWith(
            message: message,
            requestStatus: RequestStatus.loaded,
            trainers: List.from(state.trainers!)..remove(trainer))));
  }
}
