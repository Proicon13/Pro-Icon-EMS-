import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../Core/Theming/app_text_styles.dart';
import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../../../../Core/widgets/text_form_section.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required List<String> countries,
    required List<String> cities,
  })  : _formKey = formKey,
        _countries = countries,
        _cities = cities;

  final GlobalKey<FormBuilderState> _formKey;
  final List<String> _countries;
  final List<String> _cities;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 120.h),
            child: Row(
              children: [
                Expanded(
                  child: DropdownFormSection(
                    title: "Country",
                    name: "country",
                    hintText: "Select Country",
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
                        errorText: "Country is required"),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: DropdownFormSection(
                    title: "City",
                    name: "city",
                    hintText: "Select City",
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
                        errorText: "City is required"),
                  ),
                ),
              ],
            ),
          ),
          30.h.verticalSpace,
          // Full Address Field
          TextFormSection(
            title: "Full Address",
            name: "fullAddress",
            hintText: "Alrahman st-1804",
            validator: FormBuilderValidators.required(
                errorText: "Full Address is required"),
          ),
          30.h.verticalSpace,
          // Postal Code Field
          TextFormSection(
            title: "Postal Code",
            name: "postalCode",
            hintText: "123456",
            keyboardInputType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Postal code is required"),
              FormBuilderValidators.numeric(
                  errorText: "Postal code must be numeric"),
            ]),
          ),
        ],
      ),
    );
  }
}
