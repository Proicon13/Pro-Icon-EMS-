import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'text_form_section.dart';

class FullAddressFormSection extends StatelessWidget {
  final String? intialValue;
  final bool? isFieldNotRequired;
  const FullAddressFormSection({
    super.key,
    this.intialValue,
    this.isFieldNotRequired,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormSection(
      intialValue: intialValue,
      title: "register.addressLabel".tr(), // "Full Address"
      name: "fullAddress",
      hintText: "register.addressHint".tr(), // "Alrahman st-1804"
      validator: isFieldNotRequired == null
          ? FormBuilderValidators.required(
              errorText: "register.addressRequiredError"
                  .tr(), // "Full Address is required"
            )
          : null,
    );
  }
}
