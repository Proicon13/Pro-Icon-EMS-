import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../theme/app_text_styles.dart';
import 'custom_dropdown_section.dart';

class CityDropDownFormSection extends StatelessWidget {
  const CityDropDownFormSection({
    super.key,
    required List<String> cities,
    this.intialValue,
    this.isFieldNotRequired,
    this.onChanged,
    this.keyName,
  }) : _cities = cities;

  final List<String> _cities;
  final String? intialValue;
  final bool? isFieldNotRequired;
  final void Function(String?)? onChanged;
  final String? keyName;

  @override
  Widget build(BuildContext context) {
    return DropdownFormSection(
      title: "register.cityLabel".tr(), // "City"
      name: keyName ?? "city",
      onChanged: onChanged,
      initialValue: intialValue,
      hintText: "register.cityHint".tr(), // "Select City"
      items: _cities
          .map((city) => DropdownMenuItem(
                value: city,
                child: Text(
                  city,
                  style: AppTextStyles.fontSize14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ))
          .toList(),
      validator: isFieldNotRequired == null
          ? FormBuilderValidators.required(
              errorText:
                  "register.cityRequiredError".tr(), // "City is required"
            )
          : null,
    );
  }
}
