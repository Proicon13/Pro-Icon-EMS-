import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'text_form_section.dart';

class PasswordFormSection extends StatelessWidget {
  const PasswordFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormSection(
      name: 'password',
      title: 'setPasswordForm.passwordTitle'.tr(),
      obscureText: true,
      maxLines: 1,
      hintText: 'setPasswordForm.passwordHint'.tr(),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
            errorText: "setPasswordForm.passwordRequiredError".tr()),
        FormBuilderValidators.minLength(8,
            errorText: "setPasswordForm.passwordMinLengthError".tr()),
      ]),
    );
  }
}
