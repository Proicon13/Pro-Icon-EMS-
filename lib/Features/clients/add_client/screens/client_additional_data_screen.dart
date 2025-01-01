import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/cubits/phone_registration/phone_register_cubit.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_app_bar.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Features/manage_trainer/widgets/manage_trainer_form.dart';
import 'package:pro_icon/data/models/client_regestraion_request_builder.dart';

import '../../../../Core/cubits/region_cubit/region_cubit.dart';
import '../../../../Core/dependencies.dart';
import '../../../../Core/utils/get_formatted_formData.dart';

class ClientAdditionalDataScreen extends StatefulWidget {
  static const routeName = '/client-additional-data';
  final String toRoute; // the route to navigate to after adding the client
  const ClientAdditionalDataScreen({super.key, required this.toRoute});

  @override
  State<ClientAdditionalDataScreen> createState() =>
      _ClientAdditionalDataScreenState();
}

class _ClientAdditionalDataScreenState
    extends State<ClientAdditionalDataScreen> {
  late GlobalKey<FormBuilderState> _formKey;
  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      appBar: CustomAppBar(titleKey: 'userManagment.screen.addClient'.tr()),
      body: AddClientBody(
        formKey: _formKey,
      ),
      bottomNavigationBar: Padding(
        padding: SizeConstants.kBottomNavBarPadding(context),
        child: CustomButton(
            onPressed: () => _onSubmit(context), text: "confirm".tr()),
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      String? phone = _formKey.currentState?.fields['phone']?.value;

      final countryCode =
          BlocProvider.of<PhoneRegistrationCubit>(context).state.phoneCode;

      // Append the country code to the phone number
      final fullPhoneNumber = '$countryCode$phone';

      final formData = _formKey.currentState!.value;
      final updatedFormData = getFormattedFormData(formData, fullPhoneNumber);

      // use builder to build current fields
      ClientRegistrationBuilder()
          .setEmail(updatedFormData['email'])
          .setFullname(updatedFormData['fullname'])
          .setPhone(updatedFormData['phone'])
          .setAddress(updatedFormData['address'])
          .setPostalCode(updatedFormData['postalCode'])
          .setCityId(updatedFormData['cityId']);

      Navigator.of(context)
          .pushNamed(widget.toRoute, arguments: widget.toRoute);
    }
  }
}

class AddClientBody extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const AddClientBody({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<RegionCubit>(
        create: (_) => getIt<RegionCubit>()..getCountries(),
      ),
      BlocProvider<PhoneRegistrationCubit>(
        create: (_) => getIt<PhoneRegistrationCubit>(),
      )
    ], child: ManageUserForm(formKey: formKey));
  }
}
