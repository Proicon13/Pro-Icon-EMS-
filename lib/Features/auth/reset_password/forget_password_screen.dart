import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/text_form_section.dart';
import 'package:pro_icon/Features/auth/reset_password/otp_screen.dart';
import '../../../Core/Theming/app_text_styles.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/pro_icon_logo.dart';
import '../../../data/models/reset_password_request_builder.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/forget-password';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _forgetPasswordFormKey = GlobalKey<FormBuilderState>();

  // Simulate form submission
  void _submitForm(BuildContext context) {
    if (_forgetPasswordFormKey.currentState?.saveAndValidate() ?? false) {
      // Extract the form data
      final email = _forgetPasswordFormKey.currentState?.fields['email']?.value;

      // Handle success:  sending a reset email
      final builder = ResetPasswordRequestBuilder();

      builder.setEmail(email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Password reset code sent to $email",
            style: AppTextStyles.fontSize14.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      Navigator.pushReplacementNamed(context, OtpScreen.routeName);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _forgetPasswordFormKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BaseAppScaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          child: SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'Send',
              onPressed: () => _submitForm(context), // Trigger form submission
            ),
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
                Text(
                  "Forget Password",
                  style: AppTextStyles.fontSize24.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                25.h.verticalSpace,
                Text(
                  'Please enter the email associated with your account and we will send you a code to reset password',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.fontSize14
                      .copyWith(color: AppColors.white71Color),
                ),
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
    );
  }
}
