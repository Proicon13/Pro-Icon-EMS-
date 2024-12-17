import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/models/sign_up_request.dart';
import '../../../../../data/models/sign_up_request_builder.dart';
import '../../../../../data/repos/auth_repo.dart';

part 'set_password_state.dart';

class SetPasswordCubit extends Cubit<SetPasswordState> {
  final AuthRepo authRepo;
  SetPasswordCubit({required this.authRepo}) : super(const SetPasswordState());

  Future<void> registerUser({required SignupRequest signUpRequest}) async {
    emit(state.copyWith(status: SetPasswordStatus.submitting));
    final response = await authRepo.registerUser(signUpRequest: signUpRequest);

    response.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.message, status: SetPasswordStatus.error)),
        (success) => emit(state.copyWith(
            errorMessage: '', status: SetPasswordStatus.success)));

    // reset sign up builder
    SignupRequestBuilder().reset();
  }
}
