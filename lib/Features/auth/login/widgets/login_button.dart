import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Features/main/main_screen.dart';

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
          buildCustomAlert(context, state.errorMessage!, Colors.red);
        }
        if (state.loginStatus == LoginStatus.success) {
          // navigate to home screen
          buildCustomAlert(context, "login.success".tr(), Colors.green);

          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
          });
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
