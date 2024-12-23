import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/custom_loader.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';
import '../../login/screens/login_screen.dart';
import '../cubits/set_new_password/set_new_password_cubit.dart';
import '../screens/forget_password_screen.dart';

class ConfirmButton extends StatelessWidget {
  final void Function(BuildContext) onSubmit;
  const ConfirmButton({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: BlocConsumer<SetNewPasswordCubit, SetNewPasswordState>(
          listener: (context, state) {
            if (state.status == SetNewPasswordStatus.error) {
              buildCustomAlert(context, state.responseMessage!, Colors.red);

              Future.delayed(const Duration(seconds: 2), () {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(
                      context, ForgetPasswordScreen.routeName);
                }
              });
            }
            if (state.status == SetNewPasswordStatus.success) {
              buildCustomAlert(context, state.responseMessage!, Colors.green);

              Future.delayed(const Duration(seconds: 2), () {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                }
              });
            }
          },
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status == SetNewPasswordStatus.submitting) {
              return const CustomLoader();
            }
            return CustomButton(
              text: "confirm".tr(),
              onPressed: () => onSubmit(context),
            );
          },
        ));
  }
}
