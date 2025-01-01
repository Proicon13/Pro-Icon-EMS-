import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extract_local_phone.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/cubits/region_cubit/region_cubit.dart';
import '../../../Core/entities/user_entity.dart';
import '../../../Core/widgets/city_dropdown_form_section.dart';
import '../../../Core/widgets/country_dropdown_form_section.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../../../Core/widgets/full_address_form_section.dart';
import '../../../Core/widgets/fullname_form_section.dart';
import '../../../Core/widgets/postalCode_form_section.dart';
import '../../auth/register/widgets/phone_form_section.dart';

class ManageUserForm extends StatelessWidget {
  final UserEntity? trainer;
  final GlobalKey<FormBuilderState> formKey;

  const ManageUserForm({
    super.key,
    this.trainer,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            _verticalSpace(context),
            _buildFullNameSection(),
            _verticalSpace(context),
            _buildPhoneSection(),
            _verticalSpace(context),
            _buildRegionSection(),
            _verticalSpace(context),
            _buildFullAddressSection(),
            _verticalSpace(context),
            _buildPostalCodeSection(),
          ],
        ),
      ),
    );
  }

  Widget _verticalSpace(BuildContext context) =>
      context.setMinSize(30).verticalSpace;

  Widget _buildFullNameSection() {
    return FullNameFormSection(
      intialValue: trainer?.fullname ?? "",
    );
  }

  Widget _buildPhoneSection() {
    return PhoneFormSection(
      intialValue: trainer != null ? extractLocalNumber(trainer!.phone!) : "",
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
        final intialCountryValue = (trainer?.city?.country != null &&
                (state.countries?.contains(trainer!.city!.country) ?? false)
            ? trainer!.city!.country
            : null);

        final intialCityValue = (trainer?.city != null &&
                (state.cities?.contains(trainer!.city!) ?? false)
            ? trainer!.city
            : null);
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

  Widget _buildFullAddressSection() {
    return FullAddressFormSection(
      intialValue: trainer?.address ?? "",
    );
  }

  Widget _buildPostalCodeSection() {
    return PostalCodeFormSection(
      intialValue: trainer?.postalCode ?? "",
    );
  }
}
