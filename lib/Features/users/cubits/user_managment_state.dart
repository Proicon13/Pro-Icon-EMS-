part of 'user_managment_cubit.dart';

enum UserVariations { trainer, client }

enum RequestStatus { loading, loaded, error }

class UserManagmentState extends Equatable {
  final List<UserEntity>? trainers;
  final List<UserEntity>? clients;
  final List<UserEntity>? searchList;
  final String? message;
  final RequestStatus? requestStatus;
  final UserVariations? currentVariation;
  final int? currentTrainersPage;
  final int? totalTrainersPage;
  final int? totalClientsPage;
  final int? currentClientsPage;
  final bool? isSearching;
  final bool? isPaginationLoading;

  const UserManagmentState(
      {this.trainers = const [],
      this.isPaginationLoading = false,
      this.totalTrainersPage = -1,
      this.totalClientsPage = -1,
      this.clients = const [],
      this.message = "",
      this.isSearching = false,
      this.searchList = const [],
      this.currentTrainersPage = 1,
      this.currentClientsPage = 1,
      this.requestStatus = RequestStatus.loading,
      this.currentVariation = UserVariations.trainer});

  UserManagmentState copyWith(
      {List<UserEntity>? trainers,
      List<UserEntity>? clients,
      String? message,
      RequestStatus? requestStatus,
      UserVariations? currentVariation,
      int? currentTrainersPage,
      int? currentClientsPage,
      int? totalTrainersPage,
      int? totalClientsPage,
      bool? isSearching,
      List<UserEntity>? searchList,
      bool? isPaginationLoading}) {
    return UserManagmentState(
        trainers: trainers ?? this.trainers,
        clients: clients ?? this.clients,
        totalClientsPage: totalClientsPage ?? this.totalClientsPage,
        totalTrainersPage: totalTrainersPage ?? this.totalTrainersPage,
        message: message ?? this.message,
        requestStatus: requestStatus ?? this.requestStatus,
        currentVariation: currentVariation ?? this.currentVariation,
        currentTrainersPage: currentTrainersPage ?? this.currentTrainersPage,
        currentClientsPage: currentClientsPage ?? this.currentClientsPage,
        isSearching: isSearching ?? this.isSearching,
        searchList: searchList ?? this.searchList,
        isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading);
  }

  @override
  List<Object> get props => [
        trainers!,
        clients!,
        message!,
        requestStatus!,
        currentVariation!,
        currentTrainersPage!,
        currentClientsPage!,
        isSearching!,
        searchList!,
        totalClientsPage!,
        totalTrainersPage!,
        isPaginationLoading!
      ];
}
