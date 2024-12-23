import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../Core/widgets/text_form_section.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const LoginForm({
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
          40.h.verticalSpace,
          // Password Field
          TextFormSection(
            name: 'password',
            title: 'setPasswordForm.passwordTitle'.tr(),
            obscureText: true,
            hintText: 'setPasswordForm.passwordHint'.tr(),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "setPasswordForm.passwordRequiredError".tr()),
              FormBuilderValidators.minLength(8,
                  errorText: "setPasswordForm.passwordMinLengthError".tr()),
            ]),
          ),
        ],
      ),
    );
  }
}
