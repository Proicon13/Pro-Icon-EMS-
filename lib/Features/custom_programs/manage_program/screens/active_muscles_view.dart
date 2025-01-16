import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/program_muscles_cubit.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/widgets/muscle_form_section.dart';
import 'package:pro_icon/Features/custom_programs/my_programs/my_programs_screen.dart';

import '../../../../Core/widgets/custom_loader.dart';
import '../../../../data/models/add_custom_program_builder.dart';
import '../../../../data/models/add_custom_program_model.dart';
import '../../../../data/models/muscle.dart';
import '../widgets/muscle_list_section.dart';

class ActiveMusclesView extends StatefulWidget {
  const ActiveMusclesView({super.key});

  @override
  State<ActiveMusclesView> createState() => _ActiveMusclesViewState();
}

class _ActiveMusclesViewState extends State<ActiveMusclesView> {
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
    final manageProgramCubit = context.read<ManageCustomProgramCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          context.setMinSize(30).verticalSpace,
          MusclesListSection(
            formKey: _formKey,
            manageProgramCubit: manageProgramCubit,
            mode: MuscleFormMode.active,
          ),
          context.setMinSize(30).verticalSpace,
          _buildBlocConsumer(context, manageProgramCubit),
        ],
      ),
    );
  }

  Widget _buildBlocConsumer(
      BuildContext context, ManageCustomProgramCubit manageProgramCubit) {
    return BlocConsumer<ManageCustomProgramCubit, ManageCustomProgramState>(
      buildWhen: (previous, current) =>
          previous.addProgramStatus != current.addProgramStatus,
      listener: (context, state) {
        _handleAddProgramStatus(context, state, manageProgramCubit);
      },
      builder: (context, state) {
        if (state.addProgramStatus == RequetsStatus.loading) {
          return const CustomLoader();
        }
        return _buildConfirmButton(context, manageProgramCubit);
      },
    );
  }

  void _handleAddProgramStatus(
      BuildContext context,
      ManageCustomProgramState state,
      ManageCustomProgramCubit manageProgramCubit) {
    if (state.addProgramStatus == RequetsStatus.success) {
      _showAlert(context, state.message!, Colors.green);
      Future.delayed(const Duration(seconds: 3), () {
        manageProgramCubit.setAddProgramStatus(RequetsStatus.intial);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, MyProgramsScreen.routeName);
        }
      });
    } else if (state.addProgramStatus == RequetsStatus.error) {
      _showAlert(context, state.message!, Colors.red);
      Future.delayed(const Duration(seconds: 3), () {
        manageProgramCubit.setAddProgramStatus(RequetsStatus.intial);
      });
    }
  }

  Widget _buildConfirmButton(
      BuildContext context, ManageCustomProgramCubit manageProgramCubit) {
    return CustomButton(
      onPressed: () {
        if (manageProgramCubit.state.isEditMode) return;
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          _handleFormSubmission(context, manageProgramCubit);
        }
      },
      text: "confirm".tr(),
    );
  }

  void _handleFormSubmission(
      BuildContext context, ManageCustomProgramCubit manageProgramCubit) {
    // Get form data
    final formData = _formKey.currentState!.value;

    // Get the program muscles map from the cubit
    final programMusclesMap =
        context.read<ProgramMusclesCubit>().state.programMuscles!;
    final programMusclesMapCopy =
        Map<Muscle, AddProgramMuscleModel>.from(programMusclesMap);

    // Update program muscles map with form data
    programMusclesMapCopy.updateAll((key, muscleData) {
      final formValue = formData[key.name];
      if (formValue != null) {
        return muscleData.copyWith(
          isActive: formValue as bool,
        );
      }
      return muscleData;
    });

    // Build the AddCustomProgramModel
    final builder = AddCustomProgramBuilder()
      ..setProgramMuscles(programMusclesMapCopy.values.toList());
    final addProgramRequest = builder.build();

    // Submit the program
    manageProgramCubit.addCustomProgram(addProgramRequest);
  }

  void _showAlert(BuildContext context, String message, Color color) {
    buildCustomAlert(context, message, color);
  }
}
