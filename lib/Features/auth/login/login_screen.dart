// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Features/auth/reset_password/forget_password_screen.dart';

import '../../../Core/Theming/app_text_styles.dart';
import '../../../Core/dependencies.dart';
import '../../../Core/utils/enums/role.dart';
import '../../../Core/utils/role_selection_helper.dart';
import '../../../Core/widgets/base_app_Scaffold.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/have_account_row.dart';

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
    return GestureDetector(
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
                  child: CustomButton(
                    text: "Login",
                    onPressed: () => _submitForm(context), // Submit the form
                  ),
                ),
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
    );
  }
}
