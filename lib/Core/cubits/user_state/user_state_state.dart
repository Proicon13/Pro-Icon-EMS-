part of 'user_state_cubit.dart';

enum UserStatus { loggedIn, loggedOut }

class UserStateState extends Equatable {
  final UserStatus? userStatus;
  final UserEntity? currentUser;
  const UserStateState(
      {this.userStatus = UserStatus.loggedOut,
      this.currentUser = const UserEntity()});

  UserStateState copyWith({UserStatus? userStatus, UserEntity? currentUser}) =>
      UserStateState(
          userStatus: userStatus ?? this.userStatus,
          currentUser: currentUser ?? this.currentUser);

  @override
  List<Object> get props => [userStatus!, currentUser!];
}
