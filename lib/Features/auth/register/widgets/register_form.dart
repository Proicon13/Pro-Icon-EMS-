import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../Core/widgets/text_form_section.dart';
import 'phone_form_section.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const RegisterForm({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          TextFormSection(
            title: "signup.fullName".tr(), // Full Name
            name: "fullName",
            hintText: "signup.fullNameHint".tr(), // Moaid Mohamed
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: "signup.fullNameRequiredError"
                    .tr(), // Full Name is required
              ),
              FormBuilderValidators.minLength(
                3,
                errorText: "signup.fullNameMinLengthError"
                    .tr(), // Name must be at least 3 characters
              ),
            ]),
          ),
          30.h.verticalSpace,
          TextFormSection(
            title: "signup.email".tr(), // Email
            name: "email",
            hintText: "signup.emailHint".tr(), // moaidmohamed123@gmail.com
            keyboardInputType: TextInputType.emailAddress,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText:
                    "signup.emailRequiredError".tr(), // Email is required
              ),
              FormBuilderValidators.email(
                errorText: "signup.emailInvalidError"
                    .tr(), // Enter a valid email address
              ),
            ]),
          ),
          30.h.verticalSpace,
          const PhoneFormSection(),
        ],
      ),
    );
  }
}
