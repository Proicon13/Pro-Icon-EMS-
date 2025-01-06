import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/repos/auth_repo.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepo authRepo;
  ForgetPasswordCubit({required this.authRepo})
      : super(const ForgetPasswordState());

  void sendCode({required String email}) async {
    emit(state.copyWith(codeRequestStatus: CodeRequestStatus.submitting));
    final response = await authRepo.forgetPassword(email: email);
    response.fold(
        (failure) => emit(state.copyWith(
            codeRequestStatus: CodeRequestStatus.error,
            codeStatusMessage: failure.message)),
        (success) => emit(state.copyWith(
            codeRequestStatus: CodeRequestStatus.success,
            codeStatusMessage: success)));
  }
}
