import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Features/auth/Admin/admin_address_screen.dart';
import 'package:pro_icon/Features/auth/login/login_screen.dart';
import 'package:pro_icon/Features/auth/register/cubit/cubit/register_cubit.dart';
import 'package:pro_icon/data/models/sign_up_request_builder.dart';

import '../../../Core/Theming/app_text_styles.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/have_account_row.dart';
import '../../../Core/widgets/text_form_section.dart';

import 'widgets/phone_form_section.dart';

final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

class RegisterScreen extends StatelessWidget {
  static const routeName = '/sign-up';

  const RegisterScreen({super.key});

  void _submitForm(BuildContext context, String phoneCode) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // handle register logic
      final builder = SignupRequestBuilder();

      final fullName = _formKey.currentState?.fields['fullName']?.value;
      final email = _formKey.currentState?.fields['email']?.value;
      final phone = _formKey.currentState?.fields['phone']?.value;

      builder
          .setFullname(fullName)
          .setEmail(email)
          .setPhone("$phoneCode$phone");

      log("Builder after Step 1: ${builder.toString()}");
      Navigator.pushNamed(context, AdminAddressScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (_) => getIt<RegisterCubit>(),
      child: BaseAppScaffold(
        resizeToAvoidButtomPadding: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  90.h.verticalSpace,
                  const Center(child: ProIconLogo()),
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
                    child: BlocSelector<RegisterCubit, RegisterState, String>(
                      selector: (state) => state.phoneCode!,
                      builder: (context, state) {
                        return CustomButton(
                          text: "Next",
                          onPressed: () => _submitForm(context, state),
                        );
                      },
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
    return FormBuilder(
      key: _formKey,
      child: Column(
        spacing: 30.h,
        children: [
          TextFormSection(
            title: "Full Name",
            name: "fullName",
            hintText: "Moaid Mohamed",
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Full Name is required"),
              FormBuilderValidators.minLength(3,
                  errorText: "Name must be at least 3 characters"),
            ]),
          ),
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
          const PhoneFormSection(),
        ],
      ),
    );
  }
}
