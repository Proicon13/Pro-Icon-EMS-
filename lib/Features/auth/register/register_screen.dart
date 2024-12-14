import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Features/auth/login/login_screen.dart';

import '../../../Core/Theming/app_text_styles.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/have_account_row.dart';
import '../../../Core/widgets/text_form_section.dart';
import 'widgets/phone_form_field.dart';
import 'widgets/phone_form_section.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
  static const routeName = '/sign-up';

  const RegisterScreen({super.key});

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Handle form submission logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form submitted successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fix the errors in the form.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      resizeToAvoidButtomPadding: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Dismiss keyboard when tapping outside
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                90.h.verticalSpace,
                Center(
                  child: SizedBox(
                    width: 200.w,
                    child: AspectRatio(
                      aspectRatio: 200.w / 60.h,
                      child: Image.asset(
                        'assets/images/logo.png', // Replace with your logo asset
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                50.h.verticalSpace,
                Text(
                  "Sign up",
                  style: AppTextStyles.fontSize24.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                40.h.verticalSpace,
                const RegisterForm(),
                40.h.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Next",
                    onPressed: () => _submitForm(context),
                  ),
                ),
                15.h.verticalSpace,
                HaveAccountRow(
                  action: "Sign in",
                  title: "Have an account?",
                  onAction: () =>
                      Navigator.pushNamed(context, LoginScreen.routeName),
                ),
                30.h.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 30.h,
        children: [
          // Full Name Field
          TextFormSection(
            title: "Full Name",
            name: "full_name",
            hintText: "Moaid Mohamed",
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Full Name is required"),
              FormBuilderValidators.minLength(3,
                  errorText: "Name must be at least 3 characters"),
            ]),
          ),

          // Email Field
          TextFormSection(
            title: "Email",
            name: "email",
            hintText: "moaidmohamed123@gmail.com",
            keyboardInputType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Email is required"),
              FormBuilderValidators.email(
                  errorText: "Enter a valid email address"),
            ]),
          ),

          const PhoneFormSection()
        ],
      ),
    );
  }
}
