import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/cubits/region_cubit/region_cubit.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/have_account_row.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Core/widgets/title_section.dart';
import 'package:pro_icon/Features/auth/register/screens/set_password_screen.dart';
import 'package:pro_icon/data/models/city_model.dart';

import '../../../../Core/dependencies.dart';
import '../../../../data/models/sign_up_request_builder.dart';
import '../../login/screens/login_screen.dart';
import '../widgets/address_form_bloc_consumer.dart';

class AdminAddressScreen extends StatefulWidget {
  static const routeName = '/admin-address';

  const AdminAddressScreen({super.key});

  @override
  State<AdminAddressScreen> createState() => _AdminAddressScreenState();
}

class _AdminAddressScreenState extends State<AdminAddressScreen> {
  final _addressFormKey = GlobalKey<FormBuilderState>();
  void _submitForm(BuildContext context, RegionState state) {
    if (state.status == RequestStatus.success) {
      // if loaing or error don`t submit
      if (_addressFormKey.currentState?.saveAndValidate() ?? false) {
        final formData = _addressFormKey.currentState?.value;
        //handle logic here
        final builder = SignupRequestBuilder();
        final city = formData!['city'] as CityModel;
        ;
        final fullAddress = formData['fullAddress'];

        final postalCode = formData['postalCode'];

        builder
            .setCityId(city.id.toString())
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
      body: KeyboardDismissable(
        child: BlocProvider<RegionCubit>(
          create: (context) => getIt<RegionCubit>()..getCountries(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: SizeConstants.kScaffoldPadding(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        context.setMinSize(90).verticalSpace,
                        const Center(
                          child: ProIconLogo(),
                        ),
                        context.setMinSize(50).verticalSpace,
                        TitleSection(
                          title: "address.title".tr(),
                          subtitle: "address.subtitle".tr(),
                        ),
                        context.setMinSize(40).verticalSpace,

                        // Address Form
                        AddressFormBlocCounsumer(
                            addressFormKey: _addressFormKey),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.setMinSize(16),
                    vertical: context.setMinSize(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<RegionCubit, RegionState>(
                        buildWhen: (previous, current) =>
                            previous.status != current.status,
                        builder: (context, state) {
                          return CustomButton(
                            text: "next".tr(),
                            onPressed: () => _submitForm(context, state),
                          );
                        },
                      ),
                    ),
                    context.setMinSize(10).verticalSpace,
                    HaveAccountRow(
                      title: "haveAccount.title".tr(),
                      action: "signin".tr(),
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
