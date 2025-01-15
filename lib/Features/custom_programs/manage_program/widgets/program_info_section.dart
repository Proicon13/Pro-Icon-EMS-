import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_loader.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/widgets/frequency_section.dart';

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
          _buildPulseFormSection(context),
          context.setMinSize(20).verticalSpace,
          _buildButton()
        ]));
  }

  Widget _buildButton() {
    return BlocConsumer<ManageCustomProgramCubit, ManageCustomProgramState>(
      buildWhen: (previous, current) =>
          previous.updateProgramStatus != current.updateProgramStatus ||
          previous.isEditMode != current.isEditMode ||
          previous.message != current.message,
      listener: (context, state) {
        if (state.updateProgramStatus == RequetsStatus.success) {
          buildCustomAlert(context, state.message!, Colors.green);
          Future.delayed(const Duration(seconds: 3), () {
            context
                .read<ManageCustomProgramCubit>()
                .setUpdateProgramStatus(RequetsStatus.intial);
          });
        }

        if (state.updateProgramStatus == RequetsStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
      },
      builder: (context, state) {
        if (state.updateProgramStatus == RequetsStatus.loading)
          return SizedBox(
            height: context.setMinSize(60),
            child: const CustomLoader(),
          );
        return CustomButton(
            onPressed: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                final cubit = context.read<ManageCustomProgramCubit>();
                final isEditMode = state.isEditMode;
                final formData = formKey.currentState!.value;
                final image = cubit.state.customProgramEntity!.image;
                if (isEditMode) {
                  // get changed fields only and update only if there is a change
                  // update program request
                } else {
                  // use builder class to build current fields then move to next page

                  cubit.setStep(1);
                }
              }
            },
            text: state.isEditMode ? "confirm".tr() : "next".tr());
      },
    );
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
    return const FrequencyCyclesSection();
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
