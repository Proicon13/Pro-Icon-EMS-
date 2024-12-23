import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'text_form_section.dart';

class EmailFormSection extends StatelessWidget {
  const EmailFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormSection(
      title: "signup.email".tr(), // Email
      name: "email",
      hintText: "signup.emailHint".tr(), // moaidmohamed123@gmail.com
      keyboardInputType: TextInputType.emailAddress,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: "signup.emailRequiredError".tr(), // Email is required
        ),
        FormBuilderValidators.email(
          errorText:
              "signup.emailInvalidError".tr(), // Enter a valid email address
        ),
      ]),
    );
  }
}
