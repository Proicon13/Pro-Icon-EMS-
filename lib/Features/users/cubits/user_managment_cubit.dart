import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/app_user_model.dart';
import 'package:pro_icon/data/services/trainer_service.dart';

import '../../../Core/utils/enums/filteration_type.dart';

part 'user_managment_state.dart';

class UserManagmentCubit extends Cubit<UserManagmentState> {
  final TrainerService trainerService;

  UserManagmentCubit({required this.trainerService})
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

  Future<void> onSearch(String query) async {
    if (!_canPerformAction()) return;

    toggleIsSearching(true);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final currentVariation =
          state.currentVariation; // get current variation (trainers or clients)
      if (currentVariation == UserVariations.trainer && query.isNotEmpty) {
        await _searchTrainerByNameOrEmail(query); // search for trainers
      }
    });
  }

  Future<void> onFilter(FilterationType filterBy) async {
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
    if (!_canPerformAction()) return;

    emit(state.copyWith(isSearching: isSearching));
  }

  void toggleVariation(UserVariations variation) {
    if (!_canPerformAction()) return;

    emit(state.copyWith(currentVariation: variation));
  }
}
