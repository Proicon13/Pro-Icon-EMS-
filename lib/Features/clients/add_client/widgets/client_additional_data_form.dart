import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/email_form_section.dart';

import '../../../../Core/widgets/custom_date_picker_section.dart';
import '../../../../Core/widgets/gender_form_section.dart';
import '../../../../Core/widgets/height_form_section.dart';
import '../../../../Core/widgets/weight_form_section.dart';

class ClientAdditionalDataForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const ClientAdditionalDataForm({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
          key: formKey,
          child: Column(children: [
            context.setMinSize(50).verticalSpace,
            const EmailFormSection(),
            context.setMinSize(30).verticalSpace,
            const GenderFormSection(),
            context.setMinSize(30).verticalSpace,
            DatePickerFormSection(
              title: "birthDate".tr(),
              name: "birthdate",
              hintText: "birthDate.hint".tr(),
              validator: FormBuilderValidators.required(
                errorText: "birthDateRequired".tr(),
              ),
            ),
            context.setMinSize(30).verticalSpace,
            const WeightFormSection(),
            context.setMinSize(30).verticalSpace,
            const HeightFormSection(),
          ])),
    );
  }
}
