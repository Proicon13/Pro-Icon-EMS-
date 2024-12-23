import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../theme/app_text_styles.dart';
import 'custom_dropdown_section.dart';

class CountryDropDownFormSection extends StatelessWidget {
  const CountryDropDownFormSection({
    super.key,
    required List<String> countries,
  }) : _countries = countries;

  final List<String> _countries;

  @override
  Widget build(BuildContext context) {
    return DropdownFormSection(
      title: "register.countryLabel".tr(), // "Country"
      name: "country",
      hintText: "register.countryHint".tr(), // "Select Country"
      items: _countries
          .map((country) => DropdownMenuItem(
                value: country,
                child: Text(
                  country,
                  style: AppTextStyles.fontSize14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ))
          .toList(),
      validator: FormBuilderValidators.required(
        errorText:
            "register.countryRequiredError".tr(), // "Country is required"
      ),
    );
  }
}
