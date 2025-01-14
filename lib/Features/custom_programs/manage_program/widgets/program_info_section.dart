import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../../../../Core/widgets/text_form_section.dart';

class ProgramInfoForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const ProgramInfoForm({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: formKey,
        child: Column(children: [
          context.setMinSize(20).verticalSpace,
          _buildProgramNameFieldSection(context),
          _buildNumberOfCyclesSection(context),
          context.setMinSize(20).verticalSpace,
          _buildFrequencyFormSection(),
          context.setMinSize(20).verticalSpace,
          _buildContractionFormSection(context),
          _buildPulseFormSection(context)
        ]));
  }

  Widget _buildPulseFormSection(BuildContext context) {
    return SizedBox(
      height: context.setMinSize(140),
      child: Row(children: [
        Expanded(
          child: TextFormSection(
            title: "Pulse",
            name: "pulse",
            hintText: "50 u.s.",
            keyboardInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: "Pulse is required"),
            ]),
          ),
        ),
        context.setMinSize(30).horizontalSpace,
        Expanded(
            child: TextFormSection(
          title: "Stimulation",
          name: "stimulation",
          hintText: "s*10",
          keyboardInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3)
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: "Stimulation is required"),
          ]),
        ))
      ]),
    );
  }

  SizedBox _buildContractionFormSection(BuildContext context) {
    return SizedBox(
      height: context.setMinSize(140),
      child: Row(children: [
        Expanded(
          child: TextFormSection(
            title: "Contraction (sec)",
            name: "contraction",
            hintText: "10s",
            keyboardInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3)
            ],
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Contraction is required"),
            ]),
          ),
        ),
        context.setMinSize(30).horizontalSpace,
        Expanded(
            child: TextFormSection(
          title: "Pause interval (sec)",
          name: "pauseInterval",
          hintText: "10 mins",
          keyboardInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3)
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText: "Pause interval is required"),
          ]),
        ))
      ]),
    );
  }

  Widget _buildFrequencyFormSection() {
    return TextFormSection(
      title: "Frequency (HZ)",
      name: "frequency",
      hintText: "500 HZ",
      keyboardInputType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3)
      ],
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Frequency is required"),
      ]),
    );
  }

  Widget _buildNumberOfCyclesSection(BuildContext context) {
    return DropdownFormSection<int>(
      title: "Cycles No.",
      name: "cycles",
      items: [1, 2, 3, 4, 5, 6]
          .map((number) => DropdownMenuItem<int>(
                value: number,
                child: Text(
                  number.toString(),
                  style: AppTextStyles.fontSize14(context).copyWith(
                    color: Colors.white,
                  ),
                ),
              ))
          .toList(),
      hintText: "Number of Cycles",
    );
  }

  Widget _buildProgramNameFieldSection(BuildContext context) {
    return SizedBox(
      height: context.setMinSize(140),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: TextFormSection(
            title: "Name",
            name: "name",
            hintText: "Program Name",
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Program Name is required"),
              FormBuilderValidators.maxLength(50,
                  errorText: "Program Name cannot exceed 50 characters"),
            ]),
          ),
        ),
        context.setMinSize(30).horizontalSpace,
        Expanded(
            flex: 1,
            child: TextFormSection(
              title: "Duration (min)",
              name: "duration",
              hintText: "10 mins",
              keyboardInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3)
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Duration is required"),
              ]),
            ))
      ]),
    );
  }
}
