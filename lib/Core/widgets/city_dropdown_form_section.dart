import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../data/models/city_model.dart';
import '../theme/app_text_styles.dart';
import 'custom_dropdown_section.dart';

class CityDropDownFormSection extends StatelessWidget {
  const CityDropDownFormSection({
    super.key,
    required List<CityModel> cities,
    this.initialValue,
    this.isFieldNotRequired,
    this.onChanged,
    this.keyName,
  }) : _cities = cities;

  final List<CityModel> _cities;
  final CityModel? initialValue;
  final bool? isFieldNotRequired;
  final void Function(CityModel?)? onChanged;
  final String? keyName;

  @override
  Widget build(BuildContext context) {
    return DropdownFormSection<CityModel>(
      title: "register.cityLabel".tr(), // "City"
      name: keyName ?? "city",
      onChanged: onChanged,
      initialValue: initialValue,
      hintText: "register.cityHint".tr(), // "Select City"
      items: _cities
          .map((city) => DropdownMenuItem<CityModel>(
                value: city,
                child: Text(
                  city.name, // Assuming CityModel has a `name` property
                  style: AppTextStyles.fontSize14(context).copyWith(
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
