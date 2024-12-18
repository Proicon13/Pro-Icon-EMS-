import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';

import 'package:pro_icon/Core/widgets/text_form_section.dart';
import 'package:pro_icon/Core/widgets/title_section.dart';
import 'package:pro_icon/Features/auth/reset_password/cubits/forget_password/forget_password_cubit.dart';

import '../../../Core/dependencies.dart';

import '../../../Core/widgets/pro_icon_logo.dart';
import '../../../data/models/reset_password_request_builder.dart';
import 'widgets/send_code_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/forget-password';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _forgetPasswordFormKey = GlobalKey<FormBuilderState>();

  // Simulate form submission
  void _submitForm(BuildContext context, CodeRequestStatus status) {
    if (_forgetPasswordFormKey.currentState?.saveAndValidate() ?? false) {
      // Extract the form data
      final email = _forgetPasswordFormKey.currentState?.fields['email']?.value;

      // Handle success:  sending a reset email
      final builder = ResetPasswordRequestBuilder();

      builder.setEmail(email);

      BlocProvider.of<ForgetPasswordCubit>(context, listen: false)
          .sendCode(email: email!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _forgetPasswordFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissable(
      child: BlocProvider<ForgetPasswordCubit>(
        create: (context) => getIt<ForgetPasswordCubit>(),
        child: BaseAppScaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: SendCodeButton(
              onSubmit: _submitForm,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  90.h.verticalSpace,
                  const Center(
                    child: ProIconLogo(),
                  ),
                  50.h.verticalSpace,
                  const TitleSection(
                      title: "Forget Password",
                      subtitle:
                          'Please enter the email associated with your account and we will send you a code to reset password'),
                  50.h.verticalSpace,
                  FormBuilder(
                    key: _forgetPasswordFormKey,
                    child: Column(
                      children: [
                        TextFormSection(
                          title: 'Email',
                          name: 'email',
                          hintText: 'someone@gmail.com',
                          keyboardInputType: TextInputType.emailAddress,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "Email is required"),
                            FormBuilderValidators.email(
                                errorText: "Enter a valid email address"),
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
