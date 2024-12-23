import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/custom_loader.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';
import '../cubits/forget_password/forget_password_cubit.dart';
import '../screens/otp_screen.dart';

class SendCodeButton extends StatelessWidget {
  final void Function(BuildContext, CodeRequestStatus) onSubmit;
  const SendCodeButton({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.codeRequestStatus == CodeRequestStatus.success) {
            buildCustomAlert(context, state.codeStatusMessage!, Colors.green);

            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, OtpScreen.routeName);
              }
            });
          }
          if (state.codeRequestStatus == CodeRequestStatus.error) {
            buildCustomAlert(context, state.codeStatusMessage!, Colors.red);
          }
        },
        buildWhen: (previous, current) =>
            previous.codeRequestStatus != current.codeRequestStatus,
        builder: (context, state) {
          if (state.codeRequestStatus == CodeRequestStatus.submitting) {
            return SizedBox(
              height: 50.h,
              child: const CustomLoader(),
            );
          }
          return CustomButton(
              text: 'Send',
              onPressed: () => onSubmit(context, state.codeRequestStatus!));
        },
      ),
    );
  }
}
