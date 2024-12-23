import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../Core/theme/app_text_styles.dart';
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
                      errorText: "register.countryRequiredError"
                          .tr(), // "Country is required"
                    ),
                  ),
                ),
                16.w.horizontalSpace,
                Expanded(
                  child: DropdownFormSection(
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
                      errorText: "register.cityRequiredError"
                          .tr(), // "City is required"
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.h.verticalSpace,
          // Full Address Field
          TextFormSection(
            title: "register.addressLabel".tr(), // "Full Address"
            name: "fullAddress",
            hintText: "register.addressHint".tr(), // "Alrahman st-1804"
            validator: FormBuilderValidators.required(
              errorText: "register.addressRequiredError"
                  .tr(), // "Full Address is required"
            ),
          ),
          30.h.verticalSpace,
          // Postal Code Field
          TextFormSection(
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
          ),
        ],
      ),
    );
  }
}
