import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_loader.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/widgets/frequency_section.dart';
import 'package:pro_icon/data/models/add_custom_program_model.dart';

import '../../../../Core/widgets/text_form_section.dart';
import '../../../../data/models/add_custom_program_builder.dart';

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
          _buildButton(),
          context.setMinSize(20).verticalSpace,
        ]));
  }

  Widget _buildPulseFormSection(BuildContext context) {
    return SizedBox(
      height: context.setMinSize(140),
      child: Row(children: [
        Expanded(
          child: BlocSelector<ManageCustomProgramCubit,
              ManageCustomProgramState, int>(
            selector: (state) => state.customProgramEntity?.pulse ?? 0,
            builder: (context, pulse) {
              return TextFormSection(
                title: "Pulse",
                name: "pulse",
                hintText: "50 u.s.",
                intialValue: pulse.toString(),
                keyboardInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Pulse is required"),
                ]),
              );
            },
          ),
        ),
        context.setMinSize(30).horizontalSpace,
        Expanded(
          child: BlocSelector<ManageCustomProgramCubit,
              ManageCustomProgramState, int>(
            selector: (state) =>
                (state.customProgramEntity as CustomProgramEntity).stimulation,
            builder: (context, stimulation) {
              return TextFormSection(
                title: "Stimulation",
                name: "stimulation",
                hintText: "s*10",
                intialValue: stimulation.toString(),
                keyboardInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Stimulation is required"),
                ]),
              );
            },
          ),
        )
      ]),
    );
  }

  SizedBox _buildContractionFormSection(BuildContext context) {
    return SizedBox(
      height: context.setMinSize(140),
      child: Row(children: [
        Expanded(
          child: BlocSelector<ManageCustomProgramCubit,
              ManageCustomProgramState, num>(
            selector: (state) =>
                (state.customProgramEntity as CustomProgramEntity).contraction,
            builder: (context, contraction) {
              return TextFormSection(
                title: "Contraction (sec)",
                name: "contraction",
                hintText: "10s",
                intialValue: contraction.toString(),
                keyboardInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Contraction is required"),
                ]),
              );
            },
          ),
        ),
        context.setMinSize(30).horizontalSpace,
        Expanded(
          child: BlocSelector<ManageCustomProgramCubit,
              ManageCustomProgramState, int>(
            selector: (state) =>
                (state.customProgramEntity as CustomProgramEntity)
                    .pauseInterval,
            builder: (context, pauseInterval) {
              return TextFormSection(
                title: "Pause interval (sec)",
                name: "pauseInterval",
                hintText: "10 mins",
                intialValue: pauseInterval.toString(),
                keyboardInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Pause interval is required"),
                ]),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _buildFrequencyFormSection() {
    return BlocSelector<ManageCustomProgramCubit, ManageCustomProgramState,
        int>(
      selector: (state) => state.customProgramEntity?.hertez ?? 0,
      builder: (context, hertez) {
        return TextFormSection(
          title: "Frequency (HZ)",
          name: "frequency",
          hintText: "500 HZ",
          intialValue: hertez.toString(),
          keyboardInputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3)
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: "Frequency is required"),
          ]),
        );
      },
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
          child: BlocSelector<ManageCustomProgramCubit,
              ManageCustomProgramState, String>(
            selector: (state) => state.customProgramEntity?.name ?? "",
            builder: (context, name) {
              return TextFormSection(
                title: "Name",
                name: "name",
                hintText: "Program Name",
                intialValue: name,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Program Name is required"),
                  FormBuilderValidators.maxLength(50,
                      errorText: "Program Name cannot exceed 50 characters"),
                ]),
              );
            },
          ),
        ),
        context.setMinSize(30).horizontalSpace,
        Expanded(
          flex: 1,
          child: BlocSelector<ManageCustomProgramCubit,
              ManageCustomProgramState, int>(
            selector: (state) => state.customProgramEntity?.duration ?? 0,
            builder: (context, duration) {
              return TextFormSection(
                title: "Duration (min)",
                name: "duration",
                hintText: "10 mins",
                intialValue: duration.toString(),
                keyboardInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3)
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Duration is required"),
                ]),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _buildButton() {
    return BlocConsumer<ManageCustomProgramCubit, ManageCustomProgramState>(
      buildWhen: (previous, current) =>
          previous.updateProgramStatus != current.updateProgramStatus ||
          previous.isEditMode != current.isEditMode ||
          previous.message != current.message,
      listener: (context, state) {
        if (state.updateProgramStatus == RequetsStatus.success) {
          _showSuccessAlert(context, state.message!);
          _setIntialStatus(context);
        } else if (state.updateProgramStatus == RequetsStatus.error) {
          _showErrorAlert(context, state.message!);
          _setIntialStatus(context);
        }
      },
      builder: (context, state) {
        if (state.updateProgramStatus == RequetsStatus.loading) {
          return SizedBox(
            height: context.setMinSize(60),
            child: const CustomLoader(),
          );
        }
        return CustomButton(
          onPressed: () => _handleSubmit(context, state),
          text: state.isEditMode ? "confirm".tr() : "next".tr(),
        );
      },
    );
  }

  Future<Null> _setIntialStatus(BuildContext context) {
    return Future.delayed(const Duration(seconds: 1), () {
      context.read<ManageCustomProgramCubit>().setUpdateProgramStatus(
            RequetsStatus.intial,
          );
    });
  }

  void _handleSubmit(BuildContext context, ManageCustomProgramState state) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final cubit = context.read<ManageCustomProgramCubit>();
      final formData = formKey.currentState!.value;
      final programCycles = List.from(cubit.state.cycles)
          .map((cycle) => AddCycleModel.fromCycle(cycle))
          .toList();

      if (state.isEditMode) {
        _handleEditMode(cubit, state, formData, programCycles);
      } else {
        _handleCreateMode(cubit, formData, programCycles);
      }
    }
  }

  void _handleEditMode(
      ManageCustomProgramCubit cubit,
      ManageCustomProgramState state,
      Map<String, dynamic> formData,
      List<AddCycleModel> cycles) {
    final cyclesJson = cycles.map((cycle) => cycle.toJson()).toList();
    final currentProgram =
        cubit.state.customProgramEntity! as CustomProgramEntity;
    final updatedFields =
        _extractChangedFields(currentProgram, formData, cyclesJson);
    // if image only is file update it
    if (currentProgram.image.startsWith('/')) {
      updatedFields['file'] = currentProgram.image;
    }

    if (updatedFields.isEmpty) return;
    cubit.updateCustomProgram(updatedFields, currentProgram.id);
  }

  Map<String, dynamic> _extractChangedFields(CustomProgramEntity currentProgram,
      Map<String, dynamic> formData, List<dynamic> cycles) {
    final updatedFields = <String, dynamic>{};

    if (formData['name'] != currentProgram.name) {
      updatedFields['name'] = formData['name'];
    }
    if (int.parse(formData['duration']) != currentProgram.duration) {
      updatedFields['duration'] = int.parse(formData['duration']);
    }
    if (int.parse(formData['pulse']) != currentProgram.pulse) {
      updatedFields['pulse'] = int.parse(formData['pulse']);
    }
    if (int.parse(formData['frequency']) != currentProgram.hertez) {
      updatedFields['hertez'] = int.parse(formData['frequency']);
    }
    if (int.parse(formData['stimulation']) != currentProgram.stimulation) {
      updatedFields['stimulation'] = int.parse(formData['stimulation']);
    }
    if (int.parse(formData['pauseInterval']) != currentProgram.pauseInterval) {
      updatedFields['pauseInterval'] = int.parse(formData['pauseInterval']);
    }
    if (double.parse(formData['contraction']) != currentProgram.contraction) {
      updatedFields['contraction'] = double.parse(formData['contraction']);
    }

    updatedFields['cycles'] = cycles;

    return updatedFields;
  }

  void _handleCreateMode(ManageCustomProgramCubit cubit,
      Map<String, dynamic> formData, List<AddCycleModel> programCycles) {
    final builder = AddCustomProgramBuilder()
      ..reset()
      ..setName(formData['name'])
      ..setDuration(int.parse(formData['duration']))
      ..setPulse(int.parse(formData['pulse']))
      ..setHertez(int.parse(formData['frequency']))
      ..setStimulation(int.parse(formData['stimulation']))
      ..setPauseInterval(int.parse(formData['pauseInterval']))
      ..setContraction(int.parse(formData['contraction']))
      ..setCycles(programCycles);

    builder.build();
    cubit.setStep(1);
  }

  void _showSuccessAlert(BuildContext context, String message) {
    buildCustomAlert(context, message, Colors.green);
    Future.delayed(const Duration(seconds: 3), () {
      context
          .read<ManageCustomProgramCubit>()
          .setUpdateProgramStatus(RequetsStatus.intial);
    });
  }

  void _showErrorAlert(BuildContext context, String message) {
    buildCustomAlert(context, message, Colors.red);
  }
}
