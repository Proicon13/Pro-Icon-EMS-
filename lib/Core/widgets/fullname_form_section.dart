import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'text_form_section.dart';

class FullNameFormSection extends StatelessWidget {
  const FullNameFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormSection(
      title: "signup.fullName".tr(), // Full Name
      name: "fullName",
      hintText: "signup.fullNameHint".tr(), // Moaid Mohamed
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText:
              "signup.fullNameRequiredError".tr(), // Full Name is required
        ),
        FormBuilderValidators.minLength(
          3,
          errorText: "signup.fullNameMinLengthError"
              .tr(), // Name must be at least 3 characters
        ),
      ]),
    );
  }
}
