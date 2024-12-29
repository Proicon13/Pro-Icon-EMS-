import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'text_form_section.dart';

class FullNameFormSection extends StatelessWidget {
  final String? intialValue;

  const FullNameFormSection({
    super.key,
    this.intialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormSection(
      title: "signup.fullName".tr(), // Full Name
      name: "fullName",
      intialValue: intialValue,
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
