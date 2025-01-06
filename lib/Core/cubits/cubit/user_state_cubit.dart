import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/app_user_model.dart';
import 'package:pro_icon/data/repos/auth_repo.dart';

import '../../../data/services/user_service.dart';

part 'user_state_state.dart';

class UserStateCubit extends Cubit<UserStateState> {
  final UserService userService;
  final AuthRepo authRepo;
  UserStateCubit({required this.userService, required this.authRepo})
      : super(const UserStateState());

  Future<void> intializeUser() async {
    final token = await userService.getToken();
    if (token == null) {
      _setUserUnlogged();
    } else {
      final userResponse = await userService.getUserByToken(token: token);
      if (userResponse.isSuccess) {
        // if user data retrieved
        emit(state.copyWith(
            currentUser: userResponse.data, userStatus: UserStatus.loggedIn));
      } else {
        // if user data not retrieved chage state
        _setUserUnlogged();
      }
    }
  }

  Future<void> logOut() async {
    await authRepo.logout();

    _setUserUnlogged();
  }

  void _setUserUnlogged() {
    emit(state.copyWith(
      userStatus: UserStatus.loggedOut,
      currentUser: null,
    ));
  }
}
