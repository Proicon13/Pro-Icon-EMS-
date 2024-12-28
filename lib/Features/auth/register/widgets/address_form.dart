import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/data/models/city_model.dart';
import 'package:pro_icon/data/models/country_model.dart';

import '../../../../Core/widgets/city_dropdown_form_section.dart';
import '../../../../Core/widgets/country_dropdown_form_section.dart';
import '../../../../Core/widgets/full_address_form_section.dart';
import '../../../../Core/widgets/postalCode_form_section.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required List<CountryModel> countries,
    required List<CityModel> cities,
  })  : _formKey = formKey,
        _countries = countries,
        _cities = cities;

  final GlobalKey<FormBuilderState> _formKey;
  final List<CountryModel> _countries;
  final List<CityModel> _cities;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          SizeConfig(
            baseSize: const Size(398, 125),
            width: context.setMinSize(398),
            height: context.setMinSize(125),
            child: Builder(builder: (context) {
              return SizedBox(
                height: context.sizeConfig.height,
                child: Row(
                  children: [
                    Expanded(
                      child: CountryDropDownFormSection(countries: _countries),
                    ),
                    context.setMinSize(16).horizontalSpace,
                    Expanded(
                      child: CityDropDownFormSection(cities: _cities),
                    ),
                  ],
                ),
              );
            }),
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
