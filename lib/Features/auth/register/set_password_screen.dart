import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/utils/enums/role.dart';
import 'package:pro_icon/Core/utils/role_selection_helper.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';

import '../../../Core/Theming/app_text_styles.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/have_account_row.dart';
import '../../../Core/widgets/pro_icon_logo.dart';
import '../../../Core/widgets/text_form_section.dart';
import '../../../data/models/sign_up_request_builder.dart';
import '../login/login_screen.dart';

final _formKey = GlobalKey<FormBuilderState>();

class SetPasswordScreen extends StatelessWidget {
  static const routeName = '/set-password';
  const SetPasswordScreen({super.key});

  void _submitForm(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // get form data
      final formData = _formKey.currentState?.value;
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
        log('builder after step 3: ${builder.toString()}');

        // handle sign up request here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      resizeToAvoidButtomPadding: true,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
            FormBuilder(
                key: _formKey,
                child: Column(
                  spacing: 30.h,
                  children: [
                    TextFormSection(
                      name: 'password',
                      title: 'Password',
                      obscureText: true,
                      hintText: 'Enter your password',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: " Confirm Password is required"),
                      ]),
                    ),
                    TextFormSection(
                      name: 'confirmPassword',
                      title: 'Confirm Password',
                      hintText: 'Enter your password',
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: " Confirm Password is required"),
                      ]),
                    ),
                  ],
                )),
            40.h.verticalSpace,
            SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Next",
                  onPressed: () => _submitForm(context),
                )),
            15.h.verticalSpace,
            HaveAccountRow(
              action: "Sign in",
              title: "Have an account?",
              onAction: () =>
                  Navigator.pushNamed(context, LoginScreen.routeName),
            ),
          ]),
        )),
      ),
    );
  }
}
