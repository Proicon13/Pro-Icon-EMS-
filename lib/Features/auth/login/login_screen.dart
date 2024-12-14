// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';

import '../../../Core/Theming/app_text_styles.dart';
import '../../../Core/dependencies.dart';
import '../../../Core/utils/enums/role.dart';
import '../../../Core/utils/role_selection_helper.dart';
import '../../../Core/widgets/base_app_Scaffold.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/text_form_section.dart';

import 'widgets/dont_have_account_row.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  static const String routeName = '/admin-auth';

  const LoginScreen({super.key});

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Handle successful form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form submitted successfully!")),
      );
    }
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

                const LoginForm(),
                10.h.verticalSpace,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add forget password functionality
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
                    ? const DontHaveAccountRow()
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 40.h,
        children: [
          TextFormSection(
            title: "Email",
            name: "email",
            hintText: "someone@gmail.com",
            keyboardInputType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Email is required"),
              FormBuilderValidators.email(
                  errorText: "Enter a valid email address"),
            ]),
          ),

          // Password Field
          TextFormSection(
            title: "Password",
            name: "password",
            hintText: "****************",
            obscureText: false,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Password is required"),
              FormBuilderValidators.minLength(6,
                  errorText: "Password must be at least 6 characters long"),
            ]),
          ),
        ],
      ),
    );
  }
}
