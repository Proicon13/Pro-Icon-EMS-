import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../theme/app_text_styles.dart';
import 'custom_dropdown_section.dart';

class CountryDropDownFormSection extends StatelessWidget {
  const CountryDropDownFormSection({
    super.key,
    required List<String> countries,
    this.intialValue,
    this.isFieldNotRequired,
    this.onChanged,
    this.keyName,
  }) : _countries = countries;
  final String? intialValue;
  final bool? isFieldNotRequired;
  final List<String> _countries;
  final void Function(String?)? onChanged;
  final String? keyName;

  @override
  Widget build(BuildContext context) {
    return DropdownFormSection(
      title: "register.countryLabel".tr(), // "Country"
      name: keyName ?? "country",
      onChanged: onChanged,
      initialValue: intialValue,
      hintText: "register.countryHint".tr(), // "Select Country"
      items: _countries
          .map((country) => DropdownMenuItem(
                value: country,
                child: Text(
                  country,
                  style: AppTextStyles.fontSize14(context).copyWith(
                    color: Colors.white,
                  ),
                ),
              ))
          .toList(),
      validator: isFieldNotRequired == null
          ? FormBuilderValidators.required(
              errorText:
                  "register.countryRequiredError".tr(), // "Country is required"
            )
          : null,
    );
  }
}
