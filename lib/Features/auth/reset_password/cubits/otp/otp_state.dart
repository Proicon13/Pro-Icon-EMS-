part of 'otp_cubit.dart';

enum ResendOtpStatus { intial, success, error }

class OtpState extends Equatable {
  final ResendOtpStatus? resendOtpStatus;
  final String? resendCodeMessage;
  const OtpState(
      {this.resendOtpStatus = ResendOtpStatus.intial,
      this.resendCodeMessage = ""});

  OtpState copyWith(
      {ResendOtpStatus? resendOtpStatus, String? resendCodeMessage}) {
    return OtpState(
        resendOtpStatus: resendOtpStatus ?? this.resendOtpStatus,
        resendCodeMessage: resendCodeMessage ?? this.resendCodeMessage);
  }

  @override
  List<Object> get props => [resendOtpStatus!, resendCodeMessage!];
}
