import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'text_form_section.dart';

class PostalCodeFormSection extends StatelessWidget {
  const PostalCodeFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormSection(
      title: "register.postalCodeLabel".tr(), // "Postal Code"
      name: "postalCode",
      hintText: "register.postalCodeHint".tr(), // "123456"
      keyboardInputType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: "register.postalCodeRequiredError"
              .tr(), // "Postal code is required"
        ),
        FormBuilderValidators.numeric(
          errorText: "register.postalCodeNumericError"
              .tr(), // "Postal code must be numeric"
        ),
      ]),
    );
  }
}
