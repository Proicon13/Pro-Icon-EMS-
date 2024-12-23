import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/widgets/city_dropdown_form_section.dart';
import '../../../../Core/widgets/country_dropdown_form_section.dart';
import '../../../../Core/widgets/full_address_form_section.dart';
import '../../../../Core/widgets/postalCode_form_section.dart';

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
                  child: CountryDropDownFormSection(countries: _countries),
                ),
                16.w.horizontalSpace,
                Expanded(
                  child: CityDropDownFormSection(cities: _cities),
                ),
              ],
            ),
          ),
          20.h.verticalSpace,
          // Full Address Field
          const FullAddressFormSection(),
          30.h.verticalSpace,
          // Postal Code Field
          const PostalCodeFormSection(),
        ],
      ),
    );
  }
}
