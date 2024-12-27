import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/cubits/region_cubit/address_registration_cubit.dart';
import 'address_form.dart';

class AddressFormBlocCounsumer extends StatelessWidget {
  const AddressFormBlocCounsumer({
    super.key,
    required GlobalKey<FormBuilderState> addressFormKey,
  }) : _addressFormKey = addressFormKey;

  final GlobalKey<FormBuilderState> _addressFormKey;

  @override
  Widget build(BuildContext context) {
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
          child: AddressForm(
              formKey: _addressFormKey,
              countries: state.countries ?? [],
              cities: state.cities ?? []),
        );
      },
    );
  }
}
