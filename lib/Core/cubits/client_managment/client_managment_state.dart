part of 'client_managment_cubit.dart';

enum RequestStatus { loading, loaded, error }

extension ClientManagementStateX on ClientManagementState {
  bool get canFetchMore => currentPage <= totalPages;
}

class ClientManagementState extends Equatable {
  final List<UserEntity> clients;
  final List<UserEntity> searchList;
  final String message;
  final RequestStatus requestStatus;
  final int currentPage;
  final int totalPages;
  final bool isSearching;
  final bool isPaginationLoading;

  const ClientManagementState({
    this.clients = const [],
    this.searchList = const [],
    this.message = "",
    this.requestStatus = RequestStatus.loading,
    this.currentPage = 1,
    this.totalPages = -1,
    this.isSearching = false,
    this.isPaginationLoading = false,
  });

  ClientManagementState copyWith({
    List<UserEntity>? clients,
    List<UserEntity>? searchList,
    String? message,
    RequestStatus? requestStatus,
    int? currentPage,
    int? totalPages,
    bool? isSearching,
    bool? isPaginationLoading,
  }) {
    return ClientManagementState(
      clients: clients ?? this.clients,
      searchList: searchList ?? this.searchList,
      message: message ?? this.message,
      requestStatus: requestStatus ?? this.requestStatus,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isSearching: isSearching ?? this.isSearching,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }

  @override
  List<Object> get props => [
        clients,
        searchList,
        message,
        requestStatus,
        currentPage,
        totalPages,
        isSearching,
        isPaginationLoading,
      ];
}
