import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/custom_loader.dart';
import '../cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  final void Function(BuildContext) onSubmit;
  const LoginButton({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.loginStatus == LoginStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
        if (state.loginStatus == LoginStatus.success) {
          // navigate to home screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("login.success".tr()),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state.loginStatus == LoginStatus.submitting) {
          // loading
          return const CustomLoader();
        } else {
          return CustomButton(
            text: "login".tr(), onPressed: () => onSubmit(context),
            // Submit the form
          );
        }
      },
    );
  }
}
