// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Features/auth/login/cubit/login_cubit.dart';
import 'package:pro_icon/Features/auth/reset_password/screens/forget_password_screen.dart';
import 'package:pro_icon/data/models/login_request_.dart';

import '../../../../Core/dependencies.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/utils/enums/role.dart';
import '../../../../Core/utils/role_selection_helper.dart';
import '../../../../Core/widgets/base_app_Scaffold.dart';
import '../../../../Core/widgets/have_account_row.dart';
import '../../register/screens/register_screen.dart';
import '../widgets/login_button.dart';
import '../widgets/login_form.dart';

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
      child: KeyboardDismissable(
        child: BaseAppScaffold(
          resizeToAvoidButtomPadding: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: SizeConstants.kScaffoldPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.setMinSize(90).verticalSpace,
                  const Center(child: ProIconLogo()),
                  context.setMinSize(50).verticalSpace,
                  Text(
                    "login".tr(),
                    style: AppTextStyles.fontSize24(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  context.setMinSize(40).verticalSpace,

                  LoginForm(
                    formKey: _formKey,
                  ),
                  context.setMinSize(10).verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ForgetPasswordScreen.routeName);
                      },
                      child: Text(
                        "forgotPassword.label".tr(),
                        style: AppTextStyles.fontSize14(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  context
                      .setMinSize(30)
                      .verticalSpace, // Space between form and button
                  SizedBox(
                      width: double.infinity,
                      child: LoginButton(
                        onSubmit: _submitForm,
                      )),
                  context.setMinSize(30).verticalSpace,
                  getIt<RoleSelectionHelper>().selectedRole ==
                          Role.admin // if admin show sign up option
                      ? HaveAccountRow(
                          action: "signup".tr(),
                          title: "donthaveAccount.title".tr(),
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
