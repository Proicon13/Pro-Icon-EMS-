import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/cubits/phone_registration/phone_register_cubit.dart';
import 'package:pro_icon/Core/cubits/region_cubit/region_cubit.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_app_bar.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Features/manage_trainer/cubits/cubit/manage_trainer_cubit.dart';
import 'package:pro_icon/Features/users/screens/users_screen.dart';
import 'package:pro_icon/data/models/city_model.dart';

import '../../../Core/dependencies.dart';
import '../../../Core/widgets/custom_loader.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../../../data/models/sign_up_request_builder.dart';
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
          Future.delayed(const Duration(seconds: 3), () {
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                UsersScreen.routeName,
                (route) => false,
              );
            }
          });
        } else if (state.requestStataus == ManageTrainerStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
      },
      builder: (context, state) {
        if (state.requestStataus == ManageTrainerStatus.loading) {
          return SizedBox(
            height: context.setMinSize(60),
            child: const CustomLoader(),
          );
        } else {
          return Padding(
            padding: SizeConstants.kBottomNavBarPadding(context),
            child: CustomButton(
              onPressed: () => _onSubmit(context, widget.trainer),
              text: isEditMode ? "save".tr() : "next".tr(),
            ),
          );
        }
      },
    );
  }

  void _onSubmit(BuildContext context, UserEntity? trainer) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      String? phone = _formKey.currentState?.fields['phone']?.value;

      final countryCode =
          BlocProvider.of<PhoneRegistrationCubit>(context).state.phoneCode;

      // Append the country code to the phone number
      final fullPhoneNumber = '$countryCode$phone';

      final formData = _formKey.currentState!.value;
      final updatedFormData = _getFormattedFormData(formData, fullPhoneNumber);

      if (trainer != null) {
        // Check if the data has changed
        final hasChanges = _hasFormChanges(trainer, updatedFormData);
        if (hasChanges) {
          BlocProvider.of<ManageTrainerCubit>(context)
              .editTrainer(trainer.id!, updatedFormData);
        }
      } else {
        // use builder to build current fields
        final builder = SignupRequestBuilder();

        builder
            .setFullname(updatedFormData['fullName'])
            .setEmail(updatedFormData['email'])
            .setPhone(updatedFormData['phone'])
            .setCityId(updatedFormData['cityId'])
            .setPostalCode(updatedFormData['postalCode'])
            .setAddress(updatedFormData['fullAddress']);

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
        trainer.city?.id != formData['city'];
  }

  Map<String, dynamic> _getFormattedFormData(
      Map<String, dynamic> formData, String fullPhoneNumber) {
    {
      final updatedFormData = formData.map((key, value) {
        if (key == 'phone') {
          return MapEntry(key, fullPhoneNumber);
        }
        if (key == 'city') {
          return MapEntry("cityId", (value as CityModel).id.toString());
        }
        return MapEntry(key, value);
      });

      return updatedFormData;
    }
  }
}
