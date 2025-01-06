import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pro_icon/data/models/reset_password_request_builder.dart';
import 'package:pro_icon/data/repos/auth_repo.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepo authRepo;
  OtpCubit({required this.authRepo}) : super(const OtpState());

  void resendCode() async {
    // GET email from reset password builder
    final email = ResetPasswordRequestBuilder().build().email!;
    // resend request
    final response = await authRepo.forgetPassword(email: email);
    response.fold(
        (failure) => emit(state.copyWith(
            resendOtpStatus: ResendOtpStatus.error,
            resendCodeMessage: failure.message)),
        (success) => emit(state.copyWith(
            resendOtpStatus: ResendOtpStatus.success,
            resendCodeMessage: success)));
  }
}
