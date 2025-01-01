import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/utils/enums/gender.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../../../../Core/widgets/text_form_section.dart';

class ClientAdditionalDataForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const ClientAdditionalDataForm({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        child: Column(children: [
          context.setMinSize(50).verticalSpace,
          DropdownFormSection<Gender>(
            title: "gender".tr(),
            name: "gender",
            hintText: "Select Gender",
            initialValue: Gender.male,
            items: Gender.values
                .map((gender) => DropdownMenuItem<Gender>(
                      value: gender,
                      child: Text(
                        gender.name,
                        style: AppTextStyles.fontSize14(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ))
                .toList(),
          ),
          context.setMinSize(50).verticalSpace,
          TextFormSection(
            title: "weight".tr(),
            name: "weight",
            hintText: "90 Kg",
            keyboardInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(3),
            ],
            validator: FormBuilderValidators.required(
              errorText: "weightRequired".tr(),
            ),
          ),
          context.setMinSize(30).verticalSpace,
          TextFormSection(
            title: "height".tr(),
            name: "height",
            hintText: "180 Cm",
            keyboardInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(3),
            ],
            validator: FormBuilderValidators.required(
              errorText: "heightRequired".tr(),
            ),
          ),
        ]));
  }
}
