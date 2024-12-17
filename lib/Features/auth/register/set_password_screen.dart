import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/utils/enums/role.dart';
import 'package:pro_icon/Core/utils/role_selection_helper.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_loader.dart';
import 'package:pro_icon/Features/auth/register/cubit/cubit/set_password_cubit.dart';
import 'package:pro_icon/Features/auth/register/register_screen.dart';

import '../../../Core/Theming/app_text_styles.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/have_account_row.dart';
import '../../../Core/widgets/pro_icon_logo.dart';

import '../../../data/models/sign_up_request_builder.dart';
import '../login/login_screen.dart';
import 'widgets/set_password_from.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password does`t match')),
        );
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocProvider<SetPasswordCubit>(
          create: (context) => getIt<SetPasswordCubit>(),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              90.h.verticalSpace,
              const Center(child: ProIconLogo()),
              50.h.verticalSpace,
              Text(
                "Set Password",
                style: AppTextStyles.fontSize24.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              40.h.verticalSpace,
              SetPasswordForm(setPasswordFormKey: _setPasswordFormKey),
              40.h.verticalSpace,
              SizedBox(
                  width: double.infinity,
                  child: BlocConsumer<SetPasswordCubit, SetPasswordState>(
                    listener: (context, state) {
                      if (state.status == SetPasswordStatus.error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(state.errorMessage!)),
                        );

                        // in error case navigate to register screen
                        Future.delayed(const Duration(seconds: 2), () {
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(
                                context, RegisterScreen.routeName);
                          }
                        });
                      }
                      if (state.status == SetPasswordStatus.success) {
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
                          text: "Next",
                          onPressed: () => _submitForm(context),
                        );
                      }
                    },
                  )),
              15.h.verticalSpace,
              HaveAccountRow(
                action: "Sign in",
                title: "Have an account?",
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
