import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/cubits/phone_registration/phone_register_cubit.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/extract_local_phone.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_loader.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Core/dependencies.dart';
import '../../Core/entities/client_entity.dart';
import '../../Core/utils/enums/gender.dart';
import '../../Core/widgets/custom_snack_bar.dart';
import '../../Core/widgets/email_form_section.dart';
import '../../Core/widgets/gender_form_section.dart';
import '../../Core/widgets/height_form_section.dart';
import '../../Core/widgets/weight_form_section.dart';
import '../../Features/auth/register/widgets/phone_form_section.dart';
import '../../Features/client_details/cubit/cubit/client_details_cubit.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PhoneRegistrationCubit>(),
      child: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          child: BlocBuilder<ClientDetailsCubit, ClientDetailsState>(
            builder: (context, state) {
              if (state.status == ClientDetailsStatus.loading) {
                return const _LoadingSkeleton();
              } else if (state.status == ClientDetailsStatus.error) {
                return const Center(
                  child: Text('Error loading data',
                      style: TextStyle(color: Colors.red)),
                );
              } else {
                return _FormContent(
                  formKey: _formKey,
                  client: state.client!,
                  onSubmit: _onSubmit,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context, ClientEntity client) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final phoneCubit =
          BlocProvider.of<PhoneRegistrationCubit>(context, listen: false);
      if (phoneCubit.state.errorMessage!.isNotEmpty) return;

      final formData = Map<String, dynamic>.from(_formKey.currentState!.value);
      final fullPhoneNumber =
          '${phoneCubit.state.phoneCode}${formData['phone']}';

      formData['phone'] = fullPhoneNumber;
      formData['gender'] = (formData['gender'] as Gender).jsonName;
      formData.remove("gender-loading");

      if (_hasFormChanges(client, formData)) {
        BlocProvider.of<ClientDetailsCubit>(context).updateClient(
          formData,
          client.id!,
        );
      }
    }
  }

  bool _hasFormChanges(ClientEntity client, Map<String, dynamic> formData) {
    return client.email != formData['email'] ||
        client.phone != formData['phone'] ||
        client.weight != int.parse(formData['weight']) ||
        client.height != int.parse(formData['height']) ||
        client.gender != formData['gender'];
  }
}

class _FormContent extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final ClientEntity client;
  final void Function(BuildContext, ClientEntity) onSubmit;

  const _FormContent({
    required this.formKey,
    required this.client,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.setMinSize(30).verticalSpace,
        EmailFormSection(intialValue: client.email),
        context.setMinSize(30).verticalSpace,
        PhoneFormSection(intialValue: extractLocalNumber(client.phone!)),
        context.setMinSize(30).verticalSpace,
        WeightFormSection(intialValue: client.weight.toString()),
        context.setMinSize(30).verticalSpace,
        HeightFormSection(intialValue: client.height.toString()),
        context.setMinSize(30).verticalSpace,
        GenderFormSection(intialValue: genderMap[client.gender]),
        context.setMinSize(30).verticalSpace,
        _SaveButton(onSubmit: () => onSubmit(context, client)),
        context.setMinSize(20).verticalSpace,
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const _SaveButton({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientDetailsCubit, ClientDetailsState>(
      listener: (context, state) {
        if (state.clientUpdateStatus == ClientDetailsStatus.success) {
          buildCustomAlert(
              context, state.message ?? 'Update successful', Colors.green);
        } else if (state.clientUpdateStatus == ClientDetailsStatus.error) {
          buildCustomAlert(
              context, state.message ?? 'Update failed', Colors.red);
        }
      },
      child: Builder(
        builder: (context) {
          final status = context.select(
              (ClientDetailsCubit cubit) => cubit.state.clientUpdateStatus);
          if (status == ClientDetailsStatus.loading) {
            return SizedBox(
              height: context.setMinSize(60),
              child: const CustomLoader(),
            );
          }
          return CustomButton(onPressed: onSubmit, text: 'save'.tr());
        },
      ),
    );
  }
}

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          context.setMinSize(30).verticalSpace,
          const EmailFormSection(name: 'email-loading'),
          context.setMinSize(30).verticalSpace,
          const PhoneFormSection(),
          context.setMinSize(30).verticalSpace,
          const WeightFormSection(name: 'weight-loading'),
          context.setMinSize(30).verticalSpace,
          const HeightFormSection(name: 'height-loading'),
          context.setMinSize(30).verticalSpace,
          const GenderFormSection(name: 'gender-loading'),
        ],
      ),
    );
  }
}
