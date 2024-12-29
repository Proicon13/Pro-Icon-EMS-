import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../data/models/country_model.dart';
import '../theme/app_text_styles.dart';
import 'custom_dropdown_section.dart';

class CountryDropDownFormSection extends StatelessWidget {
  const CountryDropDownFormSection({
    super.key,
    required List<CountryModel> countries,
    this.initialValue,
    this.onChanged,
    this.keyName,
  }) : _countries = countries;

  final CountryModel? initialValue;

  final List<CountryModel> _countries;
  final void Function(CountryModel?)? onChanged;
  final String? keyName;

  @override
  Widget build(BuildContext context) {
    return DropdownFormSection<CountryModel>(
      title: "register.countryLabel".tr(), // "Country"
      name: keyName ?? "country",
      onChanged: onChanged,
      initialValue: initialValue,
      hintText: "register.countryHint".tr(), // "Select Country"
      items: _countries
          .map((country) => DropdownMenuItem<CountryModel>(
                value: country,
                child: Text(
                  country.name,
                  style: AppTextStyles.fontSize14(context).copyWith(
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
