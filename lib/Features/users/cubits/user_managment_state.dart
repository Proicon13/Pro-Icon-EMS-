part of 'user_managment_cubit.dart';

enum UserVariations { trainer, client }

enum RequestStatus { loading, loaded, error }

class UserManagmentState extends Equatable {
  final List<AppUserModel>? trainers;
  final List<AppUserModel>? clients;
  final String? errorMessage;
  final RequestStatus? requestStatus;
  final UserVariations? currentVariation;
  const UserManagmentState(
      {this.trainers = const [],
      this.clients = const [],
      this.errorMessage = "",
      this.requestStatus = RequestStatus.loaded,
      this.currentVariation = UserVariations.trainer});

  UserManagmentState copyWith({
    List<AppUserModel>? trainers,
    List<AppUserModel>? clients,
    String? errorMessage,
    RequestStatus? requestStatus,
    UserVariations? currentVariation,
  }) {
    return UserManagmentState(
      trainers: trainers ?? this.trainers,
      clients: clients ?? this.clients,
      errorMessage: errorMessage ?? this.errorMessage,
      requestStatus: requestStatus ?? this.requestStatus,
      currentVariation: currentVariation ?? this.currentVariation,
    );
  }

  @override
  List<Object> get props =>
      [trainers!, clients!, errorMessage!, requestStatus!, currentVariation!];
}
