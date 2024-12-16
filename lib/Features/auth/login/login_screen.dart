// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Features/auth/login/cubit/cubit/login_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/forget_password_screen.dart';
import 'package:pro_icon/data/models/login_request_.dart';

import '../../../Core/Theming/app_text_styles.dart';
import '../../../Core/dependencies.dart';
import '../../../Core/utils/enums/role.dart';
import '../../../Core/utils/role_selection_helper.dart';
import '../../../Core/widgets/base_app_Scaffold.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/have_account_row.dart';

import '../../../core/Theming/Colors/app_colors.dart';
import '../register/register_screen.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/admin-auth';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final formData = _formKey.currentState?.value;
      final email = formData!['email'];
      final password = formData['password'];
      final LoginRequest loginRequest =
          LoginRequest(email: email, password: password);

      BlocProvider.of<LoginCubit>(context, listen: false)
          .login(loginRequest: loginRequest);
      // handle login logic
    }
  }

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BaseAppScaffold(
          resizeToAvoidButtomPadding: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  90.h.verticalSpace,
                  const Center(child: ProIconLogo()),
                  50.h.verticalSpace,
                  Text(
                    "Login",
                    style: AppTextStyles.fontSize24.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  40.h.verticalSpace,

                  LoginForm(
                    formKey: _formKey,
                  ),
                  10.h.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ForgetPasswordScreen.routeName);
                      },
                      child: Text(
                        "Forget Password?",
                        style: AppTextStyles.fontSize14.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  30.h.verticalSpace, // Space between form and button
                  SizedBox(
                      width: double.infinity,
                      child: BlocConsumer<LoginCubit, LoginState>(
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login successful'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, state) {
                          if (state.loginStatus == LoginStatus.submitting) {
                            // loading
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            );
                          } else {
                            return CustomButton(
                              text: "Login",
                              onPressed: () =>
                                  _submitForm(context), // Submit the form
                            );
                          }
                        },
                      )),
                  30.h.verticalSpace,
                  getIt<RoleSelectionHelper>().selectedRole ==
                          Role.admin // if admin show sign up option
                      ? HaveAccountRow(
                          action: "Sign up",
                          title: "Don't have an account?",
                          onAction: () => Navigator.pushNamed(
                              context, RegisterScreen.routeName),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
