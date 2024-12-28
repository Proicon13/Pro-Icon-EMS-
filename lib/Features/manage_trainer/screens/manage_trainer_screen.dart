import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/cubits/phone_registration/phone_register_cubit.dart';
import 'package:pro_icon/Core/cubits/region_cubit/address_registration_cubit.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_app_bar.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Features/manage_trainer/cubits/cubit/manage_trainer_cubit.dart';

import '../../../Core/dependencies.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../widgets/manage_trainer_form.dart';

class ManageTrainerScreen extends StatefulWidget {
  final UserEntity? trainer;
  const ManageTrainerScreen({super.key, this.trainer});
  static const routeName = "/Manage-trainer-screen";

  @override
  State<ManageTrainerScreen> createState() => _ManageTrainerScreenState();
}

class _ManageTrainerScreenState extends State<ManageTrainerScreen> {
  late final GlobalKey<FormBuilderState> _formKey;
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
    final isEditMode = widget.trainer != null;

    return MultiBlocProvider(
      providers: [
        BlocProvider<RegionCubit>(
          create: (_) => getIt<RegionCubit>()..getCountries(),
        ),
        BlocProvider<ManageTrainerCubit>(
          create: (_) => getIt<ManageTrainerCubit>(),
        ),
        BlocProvider<PhoneRegistrationCubit>(
          create: (_) => getIt<PhoneRegistrationCubit>(),
        ),
      ],
      child: KeyboardDismissable(
        child: BaseAppScaffold(
          appBar: CustomAppBar(
            titleKey: isEditMode
                ? "userManagment.screen.editTrainer".tr()
                : "userManagment.screen.addTrainer".tr(),
          ),
          body: Padding(
            padding: SizeConstants.kScaffoldPadding(context),
            child: ManageTrainerForm(
              trainer: widget.trainer,
              formKey: _formKey,
            ),
          ),
          bottomNavigationBar: _buildManageButton(isEditMode),
        ),
      ),
    );
  }

  Widget _buildManageButton(bool isEditMode) {
    return BlocConsumer<ManageTrainerCubit, ManageTrainerState>(
      listener: (context, state) {
        if (state.requestStataus == ManageTrainerStatus.success) {
          buildCustomAlert(context, state.message!, Colors.green);
        } else if (state.requestStataus == ManageTrainerStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: SizeConstants.kBottomNavBarPadding(context),
          child: CustomButton(
            onPressed: () => _onSubmit(context, widget.trainer),
            text: isEditMode ? "save".tr() : "next".tr(),
          ),
        );
      },
    );
  }

  void _onSubmit(BuildContext context, UserEntity? trainer) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      String? phone = _formKey.currentState?.fields['phone']?.value;

      // Get the country code from the bloc

      final countryCode =
          BlocProvider.of<PhoneRegistrationCubit>(context).state.phoneCode;

      // Append the country code to the phone number
      final fullPhoneNumber = '$countryCode$phone';

      // Replace the phone value in the form data with the full phone number
      _formKey.currentState?.fields['phone']?.didChange(fullPhoneNumber);

      final formData = _formKey.currentState!.value;

      if (trainer != null) {
        // Check if the data has changed
        final hasChanges = _hasFormChanges(
          trainer,
          formData,
        );
        if (hasChanges) {
          BlocProvider.of<ManageTrainerCubit>(context)
              .editTrainer(trainer.id!, formData);
        }
      } else {
        // navigate to next screen for complete registration
        Navigator.of(context).pushNamed("/next-screen", arguments: formData);
      }
    }
  }

  bool _hasFormChanges(
    UserEntity trainer,
    Map<String, dynamic> formData,
  ) {
    return trainer.fullname != formData['fullName'] ||
        trainer.phone != formData['phone'] ||
        trainer.address != formData['fullAddress'] ||
        trainer.postalCode != formData['postalCode'] ||
        trainer.city?.name != formData['city'] ||
        trainer.city?.country.name != formData['country'];
  }
}
