import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/custom_loader.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';
import '../../login/login_screen.dart';
import '../cubit/cubit/set_password_cubit.dart';
import '../register_screen.dart';

class SetPasswordButton extends StatelessWidget {
  final void Function(BuildContext) onSubmit;
  const SetPasswordButton({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: BlocConsumer<SetPasswordCubit, SetPasswordState>(
          listener: (context, state) {
            if (state.status == SetPasswordStatus.error) {
              buildCustomSnackBar(context, state.errorMessage!, Colors.red);

              // in error case navigate to register screen
              Future.delayed(const Duration(seconds: 2), () {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(
                      context, RegisterScreen.routeName);
                }
              });
            }
            if (state.status == SetPasswordStatus.success) {
              buildCustomSnackBar(
                  context, "User created Successfully", Colors.green);
              // navigate to login screen
              Future.delayed(const Duration(seconds: 2), () {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                }
              });
            }
          },
          builder: (context, state) {
            if (state.status == SetPasswordStatus.submitting) {
              return const CustomLoader();
            } else {
              return CustomButton(
                  text: "Next", onPressed: () => onSubmit(context));
            }
          },
        ));
  }
}
