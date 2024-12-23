import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../theme/app_text_styles.dart';
import 'custom_dropdown_section.dart';

class CityDropDownFormSection extends StatelessWidget {
  const CityDropDownFormSection({
    super.key,
    required List<String> cities,
  }) : _cities = cities;

  final List<String> _cities;

  @override
  Widget build(BuildContext context) {
    return DropdownFormSection(
      title: "register.cityLabel".tr(), // "City"
      name: "city",
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
      validator: FormBuilderValidators.required(
        errorText: "register.cityRequiredError".tr(), // "City is required"
      ),
    );
  }
}
