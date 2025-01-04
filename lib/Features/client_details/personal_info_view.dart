import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/cubits/phone_registration/phone_register_cubit.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/extract_local_phone.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/gender_form_section.dart';
import 'package:pro_icon/Core/widgets/weight_form_section.dart';
import 'package:pro_icon/Features/auth/register/widgets/phone_form_section.dart';
import 'package:pro_icon/Features/client_details/cubit/cubit/client_details_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Core/dependencies.dart';
import '../../Core/utils/enums/gender.dart';
import '../../Core/widgets/custom_snack_bar.dart';
import '../../Core/widgets/email_form_section.dart';
import '../../Core/widgets/height_form_section.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
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
    return BlocProvider<PhoneRegistrationCubit>(
      create: (context) => getIt<PhoneRegistrationCubit>(),
      child: SingleChildScrollView(
        child: FormBuilder(
            key: _formKey,
            child: BlocConsumer<ClientDetailsCubit, ClientDetailsState>(
              listener: (context, state) {
                if (state.status == ClientDetailsStatus.error) {
                  buildCustomAlert(context, state.message!, Colors.red);
                }
              },
              buildWhen: (previous, current) =>
                  previous.status != current.status ||
                  previous.client != current.client,
              builder: (context, state) {
                return _buildFormContent(context, state);
              },
            )),
      ),
    );
  }

  Widget _buildFormContent(BuildContext context, ClientDetailsState state) {
    if (state.status == ClientDetailsStatus.loading) {
      return Skeletonizer(
        enabled: true,
        child: Column(
          children: [
            context.setMinSize(30).verticalSpace,
            const EmailFormSection(
              name: "email-loading",
            ),
            context.setMinSize(30).verticalSpace,
            const PhoneFormSection(),
            context.setMinSize(30).verticalSpace,
            const WeightFormSection(
              name: "weight-loading",
            ),
            context.setMinSize(30).verticalSpace,
            const HeightFormSection(
              name: "height-loading",
            ),
            context.setMinSize(30).verticalSpace,
            const GenderFormSection(
              name: "gender-loading",
            )
          ],
        ),
      );
    }
    if (state.status == ClientDetailsStatus.error) {
      return const Column(
        children: [
          SizedBox.shrink(),
        ],
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      context.setMinSize(30).verticalSpace,
      EmailFormSection(
        intialValue: state.client?.email,
      ),
      context.setMinSize(30).verticalSpace,
      PhoneFormSection(
        intialValue: extractLocalNumber(state.client!.phone!),
      ),
      context.setMinSize(30).verticalSpace,
      WeightFormSection(
        intialValue: state.client?.weight.toString(),
      ),
      context.setMinSize(30).verticalSpace,
      HeightFormSection(
        intialValue: state.client?.height.toString(),
      ),
      context.setMinSize(30).verticalSpace,
      GenderFormSection(
        intialValue: genderMap[state.client?.gender],
      ),
      context.setMinSize(30).verticalSpace,
      CustomButton(onPressed: () {}, text: "save".tr()),
    ]);
  }
}
