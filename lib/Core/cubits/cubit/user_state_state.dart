part of 'user_state_cubit.dart';

enum UserStatus { loggedIn, loggedOut }

class UserStateState extends Equatable {
  final UserStatus? userStatus;
  final AppUserModel? currentUser;
  const UserStateState(
      {this.userStatus = UserStatus.loggedOut,
      this.currentUser = const AppUserModel()});

  UserStateState copyWith(
          {UserStatus? userStatus, AppUserModel? currentUser}) =>
      UserStateState(
          userStatus: userStatus ?? this.userStatus,
          currentUser: currentUser ?? this.currentUser);

  @override
  List<Object> get props => [userStatus!, currentUser!];
}
