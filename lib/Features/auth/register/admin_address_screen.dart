import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pro_icon/Core/Theming/app_text_styles.dart';
import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/have_account_row.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';

import 'package:pro_icon/Features/auth/login/login_screen.dart';
import 'package:pro_icon/Features/auth/register/cubit/cubit/address_registration_cubit.dart';
import 'package:pro_icon/Features/auth/register/set_password_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/dependencies.dart';
import '../../../data/models/sign_up_request_builder.dart';
import 'widgets/address_form.dart';

class AdminAddressScreen extends StatefulWidget {
  static const routeName = '/admin-address';

  const AdminAddressScreen({super.key});

  @override
  State<AdminAddressScreen> createState() => _AdminAddressScreenState();
}

class _AdminAddressScreenState extends State<AdminAddressScreen> {
  final _addressFormKey = GlobalKey<FormBuilderState>();
  void _submitForm(BuildContext context, AddressRegistrationState state) {
    if (state.status == RequestStatus.success) {
      // if loaing or error don`t submit
      if (_addressFormKey.currentState?.saveAndValidate() ?? false) {
        final formData = _addressFormKey.currentState?.value;
        //handle logic here
        final builder = SignupRequestBuilder();
        final city = formData!['city'];
        final cityId = state.citiesMap![city];
        final fullAddress = formData['fullAddress'];

        final postalCode = formData['postalCode'];

        builder
            .setCityId(cityId!)
            .setAddress(fullAddress)
            .setPostalCode(postalCode);
        log(builder.toString());
        Navigator.pushReplacementNamed(context, SetPasswordScreen.routeName);
      }
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
        child: BlocProvider<AddressRegistrationCubit>(
          create: (context) =>
              getIt<AddressRegistrationCubit>()..getCountries(),
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
                        BlocConsumer<AddressRegistrationCubit,
                            AddressRegistrationState>(
                          listener: (context, state) {
                            if (state.status == RequestStatus.error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 2),
                                    content: Text(state.errorMessage!)),
                              );
                            }
                          },
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return Skeletonizer(
                              enabled: state.status == RequestStatus.loading,
                              child: AddressForm(
                                  formKey: _addressFormKey,
                                  countries: state.countries ?? [],
                                  cities: state.cities ?? []),
                            );
                          },
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
                      child: BlocBuilder<AddressRegistrationCubit,
                          AddressRegistrationState>(
                        buildWhen: (previous, current) =>
                            previous.status != current.status,
                        builder: (context, state) {
                          return CustomButton(
                            text: "Next",
                            onPressed: () => _submitForm(context, state),
                          );
                        },
                      ),
                    ),
                    15.h.verticalSpace,
                    HaveAccountRow(
                      title: "Have an account?",
                      action: "Sign in",
                      onAction: () {
                        // reset builder
                        SignupRequestBuilder().reset();
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
