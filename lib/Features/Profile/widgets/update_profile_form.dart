import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/cubits/region_cubit/region_cubit.dart';
import '../../../Core/dependencies.dart';
import '../../../Core/utils/extract_local_phone.dart';
import '../../../Core/widgets/city_dropdown_form_section.dart';
import '../../../Core/widgets/country_dropdown_form_section.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../../../Core/widgets/email_form_section.dart';
import '../../../Core/widgets/full_address_form_section.dart';
import '../../../Core/widgets/fullname_form_section.dart';
import '../../auth/register/widgets/phone_form_section.dart';

class UpdateProfileForm extends StatelessWidget {
  const UpdateProfileForm({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFullNameSection(),
            context.setMinSize(20).verticalSpace,
            _buildEmailSection(),
            context.setMinSize(20).verticalSpace,
            _buildPhoneSection(),
            context.setMinSize(20).verticalSpace,
            _buildRegionSection(),
            context.setMinSize(20).verticalSpace,
            _buildAddressSection(),
            context.setMinSize(20).verticalSpace,
            CustomButton(onPressed: () {}, text: "Confirm"),
          ],
        ));
  }

  Widget _buildAddressSection() {
    return BlocSelector<UserStateCubit, UserStateState, String>(
      selector: (state) {
        return state.currentUser!.address!;
      },
      builder: (context, state) {
        return FullAddressFormSection(
          intialValue: state,
        );
      },
    );
  }

  Widget _buildPhoneSection() {
    return BlocSelector<UserStateCubit, UserStateState, String>(
      selector: (state) {
        return state.currentUser!.phone!;
      },
      builder: (context, state) {
        return PhoneFormSection(
          intialValue: state.isEmpty ? "" : extractLocalNumber(state),
        );
      },
    );
  }

  Widget _buildEmailSection() {
    return BlocSelector<UserStateCubit, UserStateState, String>(
      selector: (state) {
        return state.currentUser!.email!;
      },
      builder: (context, state) {
        return EmailFormSection(
          intialValue: state,
        );
      },
    );
  }

  Widget _buildFullNameSection() {
    return BlocSelector<UserStateCubit, UserStateState, String>(
      selector: (state) {
        return state.currentUser!.fullname!;
      },
      builder: (context, state) {
        return FullNameFormSection(
          intialValue: state,
        );
      },
    );
  }

  Widget _buildRegionSection() {
    return BlocConsumer<RegionCubit, RegionState>(
      listener: (context, state) {
        if (state.status == RequestStatus.error) {
          buildCustomAlert(context, state.errorMessage!, Colors.red);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final intialCountryValue =
            getIt<UserStateCubit>().state.currentUser!.city!.country;

        final intialCityValue =
            getIt<UserStateCubit>().state.currentUser!.city!;
        return Skeletonizer(
          enabled: state.status == RequestStatus.loading,
          child: Builder(builder: (context) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: context.setMinSize(130)),
              child: Row(
                children: [
                  Expanded(
                    child: CountryDropDownFormSection(
                      keyName: state.status == RequestStatus.loading
                          ? "country-loading"
                          : "country",
                      countries: state.countries!,
                      onChanged: (country) {
                        if (country != null) {
                          BlocProvider.of<RegionCubit>(context)
                              .onSelectCountry(country);
                        }
                      },
                      initialValue: intialCountryValue,
                    ),
                  ),
                  context.setMinSize(20).horizontalSpace,
                  Expanded(
                    child: CityDropDownFormSection(
                      keyName: state.status == RequestStatus.loading
                          ? "city-loading"
                          : "city",
                      cities: state.cities!,
                      initialValue: intialCityValue,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
