import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/program_muscles_cubit.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/widgets/muscle_form_section.dart';

import '../../../../data/models/add_custom_program_builder.dart';
import '../../../../data/models/add_custom_program_model.dart';
import '../../../../data/models/muscle.dart';
import '../widgets/muscle_list_section.dart';

class ChronaxieView extends StatefulWidget {
  const ChronaxieView({super.key});

  @override
  State<ChronaxieView> createState() => _ChronaxieViewState();
}

class _ChronaxieViewState extends State<ChronaxieView> {
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
            mode: MuscleFormMode.value,
          ),
          context.setMinSize(30).verticalSpace,
          CustomButton(
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  final cubit = context.read<ProgramMusclesCubit>();
                  // Get muscles values from the form
                  final formData = _formKey.currentState!.value;

                  // Create a copy of the programMusclesMap
                  final programMusclesMapCopy =
                      Map<Muscle, AddProgramMuscleModel>.from(
                          cubit.state.programMuscles!);

                  // Update each muscle's value based on the form data
                  programMusclesMapCopy.updateAll((key, muscleData) {
                    final formValue = formData[key
                        .name]; // Get the corresponding form value by muscle name
                    if (formValue != null) {
                      return muscleData.copyWith(
                        value: int.tryParse(formValue) ??
                            0, // Safely parse the form value into an integer
                      );
                    }
                    return muscleData; // Return the original if no update is needed
                  });

                  cubit.setProgramMuscleMap(programMusclesMapCopy);

                  // Use the builder to update program muscles
                  AddCustomProgramBuilder()
                    ..setProgramMuscles(programMusclesMapCopy.values.toList());

                  // Move to the next step
                  manageProgramCubit.setStep(3);
                }
              },
              text: "next".tr())
        ],
      ),
    );
  }
}
