import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/utils/enums/role.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/utils/role_selection_helper.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Features/auth/register/cubits/set_password_cubit.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/have_account_row.dart';
import '../../../../Core/widgets/pro_icon_logo.dart';
import '../../../../data/models/sign_up_request_builder.dart';
import '../../login/screens/login_screen.dart';
import '../widgets/set_password_button.dart';
import '../widgets/set_password_from.dart';

class SetPasswordScreen extends StatefulWidget {
  static const routeName = '/set-password';
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _setPasswordFormKey = GlobalKey<FormBuilderState>();
  void _submitForm(BuildContext context) {
    if (_setPasswordFormKey.currentState?.validate() ?? false) {
      _setPasswordFormKey.currentState?.save();
      // get form data
      final formData = _setPasswordFormKey.currentState?.value;
      final password = formData!['password'];
      final confirmPassword = formData['confirmPassword'];
      if (password != confirmPassword) {
        buildCustomAlert(
            context, "resetPassword.passwordMismatch".tr(), Colors.red);
      } else {
        final builder = SignupRequestBuilder();
        final RoleSelectionHelper helper = getIt<RoleSelectionHelper>();
        builder.setPassword(password);
        builder.setRole(rolesMap[helper.selectedRole]!);
        final signupRequest = builder.build();
        BlocProvider.of<SetPasswordCubit>(context, listen: false)
            .registerUser(signUpRequest: signupRequest);
        log('builder after step 3: ${builder.toString()}');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _setPasswordFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      resizeToAvoidButtomPadding: true,
      body: KeyboardDismissable(
        child: BlocProvider<SetPasswordCubit>(
          create: (context) => getIt<SetPasswordCubit>(),
          child: SingleChildScrollView(
              child: Padding(
            padding: SizeConstants.kScaffoldPadding(context),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              context.setMinSize(90).verticalSpace,
              const Center(child: ProIconLogo()),
              context.setMinSize(50).verticalSpace,
              Text(
                "resetPassword.screen.title".tr(),
                style: AppTextStyles.fontSize24(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              context.setMinSize(40).verticalSpace,
              SetPasswordForm(setPasswordFormKey: _setPasswordFormKey),
              context.setMinSize(40).verticalSpace,
              SetPasswordButton(
                onSubmit: _submitForm,
              ),
              context.setMinSize(20).verticalSpace,
              HaveAccountRow(
                action: "signin".tr(),
                title: "haveAccount.title".tr(),
                onAction: () => Navigator.pushReplacementNamed(
                    context, LoginScreen.routeName),
              ),
            ]),
          )),
        ),
      ),
    );
  }
}
