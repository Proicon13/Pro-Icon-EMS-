part of 'user_managment_cubit.dart';

enum UserVariations { trainer, client }

enum RequestStatus { loading, loaded, error }

class UserManagmentState extends Equatable {
  final List<UserEntity>? trainers;
  final List<UserEntity>? clients;
  final List<UserEntity>? searchList;
  final String? errorMessage;
  final RequestStatus? requestStatus;
  final UserVariations? currentVariation;
  final int? currentTrainersPage;
  final int? currentClientsPage;
  final bool? isSearching;

  const UserManagmentState(
      {this.trainers = const [],
      this.clients = const [],
      this.errorMessage = "",
      this.isSearching = false,
      this.searchList = const [],
      this.currentTrainersPage = 1,
      this.currentClientsPage = 1,
      this.requestStatus = RequestStatus.loading,
      this.currentVariation = UserVariations.trainer});

  UserManagmentState copyWith({
    List<UserEntity>? trainers,
    List<UserEntity>? clients,
    String? errorMessage,
    RequestStatus? requestStatus,
    UserVariations? currentVariation,
    int? currentTrainersPage,
    int? currentClientsPage,
    bool? isSearching,
    List<UserEntity>? searchList,
  }) {
    return UserManagmentState(
      trainers: trainers ?? this.trainers,
      clients: clients ?? this.clients,
      errorMessage: errorMessage ?? this.errorMessage,
      requestStatus: requestStatus ?? this.requestStatus,
      currentVariation: currentVariation ?? this.currentVariation,
      currentTrainersPage: currentTrainersPage ?? this.currentTrainersPage,
      currentClientsPage: currentClientsPage ?? this.currentClientsPage,
      isSearching: isSearching ?? this.isSearching,
      searchList: searchList ?? this.searchList,
    );
  }

  @override
  List<Object> get props => [
        trainers!,
        clients!,
        errorMessage!,
        requestStatus!,
        currentVariation!,
        currentTrainersPage!,
        currentClientsPage!,
        isSearching!,
        searchList!,
      ];
}
