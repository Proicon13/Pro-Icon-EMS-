import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/Theming/app_text_styles.dart';
import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/have_account_row.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Core/widgets/text_form_section.dart';
import 'package:pro_icon/Features/auth/login/login_screen.dart';
import '../../../Core/widgets/custom_dropdown_section.dart';
import '../../../data/models/sign_up_request_builder.dart';

final _formKey = GlobalKey<FormBuilderState>();

// Sample Country and City Lists
final List<String> _countries = ["Egypt", "USA", "Canada", "UK"];
final List<String> _cities = ["Cairo", "Alexandria", "Giza", "Luxor"];

class AdminAddressScreen extends StatelessWidget {
  static const routeName = '/admin-address';

  const AdminAddressScreen({super.key});

  void _submitForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      //handle logic here
      final builder = SignupRequestBuilder();
      final city = formData!['city'];
      final fullAddress = formData['fullAddress'];

      final postalCode = formData['postalCode'];

      builder.setCityId(city).setAddress(fullAddress).setPostalCode(postalCode);
      log(builder.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      90.h.verticalSpace,
                      const Center(
                        child: ProIconLogo(),
                      ),
                      50.h.verticalSpace,
                      Text(
                        "Address",
                        style: AppTextStyles.fontSize24.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      10.h.verticalSpace,
                      Text(
                        "Enter your full address details to be associated with your email",
                        style: AppTextStyles.fontSize14.copyWith(
                          color: AppColors.white71Color,
                        ),
                      ),
                      40.h.verticalSpace,

                      // Address Form
                      AddressForm(
                        formKey: _formKey,
                        countries: _countries,
                        cities: _cities,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Next",
                      onPressed: _submitForm,
                    ),
                  ),
                  15.h.verticalSpace,
                  HaveAccountRow(
                    title: "Have an account?",
                    action: "Sign in here",
                    onAction: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
