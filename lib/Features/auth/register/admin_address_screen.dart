import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pro_icon/Core/Theming/app_text_styles.dart';
import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/have_account_row.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';

import 'package:pro_icon/Features/auth/login/login_screen.dart';
import 'package:pro_icon/Features/auth/register/set_password_screen.dart';

import '../../../data/models/sign_up_request_builder.dart';
import 'widgets/address_form.dart';

// Sample Country and City Lists
final List<String> _countries = ["Egypt", "USA", "Canada", "UK"];
final List<String> _cities = ["Cairo", "Alexandria", "Giza", "Luxor"];

class AdminAddressScreen extends StatefulWidget {
  static const routeName = '/admin-address';

  const AdminAddressScreen({super.key});

  @override
  State<AdminAddressScreen> createState() => _AdminAddressScreenState();
}

class _AdminAddressScreenState extends State<AdminAddressScreen> {
  final _addressFormKey = GlobalKey<FormBuilderState>();
  void _submitForm(BuildContext context) {
    if (_addressFormKey.currentState?.saveAndValidate() ?? false) {
      final formData = _addressFormKey.currentState?.value;
      //handle logic here
      final builder = SignupRequestBuilder();
      final city = formData!['city'];
      final fullAddress = formData['fullAddress'];

      final postalCode = formData['postalCode'];

      builder.setCityId(city).setAddress(fullAddress).setPostalCode(postalCode);
      log(builder.toString());
      Navigator.pushNamed(context, SetPasswordScreen.routeName);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _addressFormKey.currentState?.dispose();
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
                        formKey: _addressFormKey,
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
                      onPressed: () => _submitForm(context),
                    ),
                  ),
                  15.h.verticalSpace,
                  HaveAccountRow(
                    title: "Have an account?",
                    action: "Sign in",
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
