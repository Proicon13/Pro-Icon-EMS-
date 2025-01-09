import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'text_form_section.dart';

class ConfirmPasswordFormSection extends StatelessWidget {
  const ConfirmPasswordFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormSection(
      name: 'confirmPassword',
      title: 'setPasswordForm.confirmPasswordTitle'.tr(), // "Confirm Password"
      hintText: 'setPasswordForm.passwordHint'.tr(),
      obscureText: true,
      maxLines: 1,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
            errorText: "setPasswordForm.confirmPasswordRequiredError".tr()),
      ]),
    );
  }
}
