import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'text_form_section.dart';

class WeightFormSection extends StatelessWidget {
  final String? intialValue;
  final String? name;
  const WeightFormSection({
    super.key,
    this.intialValue,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormSection(
      title: "weight".tr(),
      name: name ?? "weight",
      hintText: "90 Kg",
      intialValue: intialValue,
      keyboardInputType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LengthLimitingTextInputFormatter(3),
      ],
      validator: FormBuilderValidators.required(
        errorText: "weightRequired".tr(),
      ),
    );
  }
}
