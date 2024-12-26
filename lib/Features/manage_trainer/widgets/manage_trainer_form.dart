import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/cubits/region_cubit/address_registration_cubit.dart';
import '../../../Core/entities/user_entity.dart';
import '../../../Core/widgets/city_dropdown_form_section.dart';
import '../../../Core/widgets/country_dropdown_form_section.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../../../Core/widgets/full_address_form_section.dart';
import '../../../Core/widgets/fullname_form_section.dart';
import '../../../Core/widgets/postalCode_form_section.dart';
import '../../auth/register/widgets/phone_form_section.dart';

class ManageTrainerForm extends StatelessWidget {
  final UserEntity? trainer;
  final GlobalKey<FormBuilderState> formKey;

  const ManageTrainerForm({
    super.key,
    required this.trainer,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final bool? isFieldNotRequired = trainer != null ? true : null;

    return SingleChildScrollView(
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            _verticalSpace(),
            _buildFullNameSection(isFieldNotRequired),
            _verticalSpace(),
            _buildPhoneSection(isFieldNotRequired),
            _verticalSpace(),
            _buildRegionSection(isFieldNotRequired),
            _verticalSpace(),
            _buildFullAddressSection(isFieldNotRequired),
            _verticalSpace(),
            _buildPostalCodeSection(isFieldNotRequired),
          ],
        ),
      ),
    );
  }

  Widget _verticalSpace() => 30.h.verticalSpace;

  Widget _buildFullNameSection(bool? isFieldNotRequired) {
    return FullNameFormSection(
      intialValue: trainer?.fullname ?? "",
      isFieldNotRequired: isFieldNotRequired,
    );
  }

  Widget _buildPhoneSection(bool? isFieldNotRequired) {
    return PhoneFormSection(
      intialValue: trainer?.phone ?? "",
      isFieldNotRequired: isFieldNotRequired,
    );
  }

  Widget _buildRegionSection(bool? isFieldNotRequired) {
    return BlocConsumer<RegionCubit, RegionState>(
      listener: (context, state) {
        if (state.status == RequestStatus.error) {
          buildCustomAlert(context, state.errorMessage!, Colors.red);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.status == RequestStatus.loading,
          child: Row(
            children: [
              Expanded(
                child: CountryDropDownFormSection(
                  countries: state.countries!,
                  intialValue: trainer?.city?.country.name ?? "",
                  isFieldNotRequired: isFieldNotRequired,
                ),
              ),
              20.w.horizontalSpace,
              Expanded(
                child: CityDropDownFormSection(
                  cities: state.cities!,
                  intialValue: trainer?.city?.name ?? "",
                  isFieldNotRequired: isFieldNotRequired,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFullAddressSection(bool? isFieldNotRequired) {
    return FullAddressFormSection(
      intialValue: trainer?.address ?? "",
      isFieldNotRequired: isFieldNotRequired,
    );
  }

  Widget _buildPostalCodeSection(bool? isFieldNotRequired) {
    return PostalCodeFormSection(
      intialValue: trainer?.postalCode ?? "",
      isFieldNotRequired: isFieldNotRequired,
    );
  }
}
