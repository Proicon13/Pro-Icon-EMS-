import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/reset_password_request.dart';
import 'package:pro_icon/data/repos/auth_repo.dart';

import '../../../../../data/models/reset_password_request_builder.dart';

part 'set_new_password_state.dart';

class SetNewPasswordCubit extends Cubit<SetNewPasswordState> {
  final AuthRepo authRepo;

  SetNewPasswordCubit({required this.authRepo})
      : super(const SetNewPasswordState());

  void resetPassword(ResetPasswordRequest request) async {
    // loaidng state
    emit(state.copyWith(status: SetNewPasswordStatus.submitting));
    final response =
        await authRepo.resetPassword(resetPasswordRequest: request);
    response.fold(
        (failure) => emit(state.copyWith(
            status: SetNewPasswordStatus.error,
            responseMessage: failure.message)),
        (success) => emit(state.copyWith(
            status: SetNewPasswordStatus.success, responseMessage: success)));

    // reset the reset password builder
    ResetPasswordRequestBuilder().reset();
  }
}
