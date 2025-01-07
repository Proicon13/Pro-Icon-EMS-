import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/data/repos/auth_repo.dart';

import '../../../../data/models/login_request_.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit({required this.authRepo}) : super(const LoginState());

  Future<void> login({required LoginRequest loginRequest}) async {
    emit(state.copyWith(loginStatus: LoginStatus.submitting));
    final result = await authRepo.login(loginRequest: loginRequest);
    result.fold(
        (failure) => emit(state.copyWith(
            loginStatus: LoginStatus.error,
            errorMessage: failure.message)), (user) {
      getIt<UserStateCubit>().setUser(user);
      emit(state.copyWith(loginStatus: LoginStatus.success, errorMessage: ''));
    });
  }
}
