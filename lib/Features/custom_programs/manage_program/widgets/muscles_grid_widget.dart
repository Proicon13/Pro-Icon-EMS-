import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/widgets/muscle_form_section.dart';
import 'package:pro_icon/data/models/muscle.dart';

import '../../../../data/models/add_custom_program_model.dart';
import '../cubits/cubit/program_muscles_cubit.dart';

class ProgramMusclesGrid extends StatelessWidget {
  final Map<Muscle, AddProgramMuscleModel> programMusclesMap;
  final MuscleFormMode mode;
  final ManageCustomProgramCubit manageProgramCubit;

  const ProgramMusclesGrid({
    super.key,
    required this.programMusclesMap,
    required this.mode,
    required this.manageProgramCubit,
  });

  @override
  Widget build(BuildContext context) {
    final isEditMode = manageProgramCubit.state.isEditMode;
    final currentCustomProgram = manageProgramCubit.state.customProgramEntity;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two columns
          crossAxisSpacing: context.setMinSize(40),
          mainAxisSpacing: context.setMinSize(10),
          childAspectRatio: 1.2),
      itemCount: programMusclesMap.keys.length,
      itemBuilder: (context, index) {
        final muscle = programMusclesMap.keys.elementAt(index);
        final muscleData = programMusclesMap[muscle];

        return LayoutBuilder(builder: (context, constraints) {
          return SizeConfig(
            baseSize: const Size(170, 80),
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Builder(builder: (context) {
              return SizedBox(
                height: context.sizeConfig.height,
                width: context.sizeConfig.width,
                child: MuscleFormSection(
                  muscleName: muscle.name!,
                  value: muscleData!.value!.toInt(),
                  isActive: muscleData.isActive,
                  mode: mode, // Determine mode
                  onChange: (newValue) {
                    if (!isEditMode) return;

                    if (mode == MuscleFormMode.value && isEditMode) {
                      if (newValue != null) {
                        context
                            .read<ProgramMusclesCubit>()
                            .updateMuscleValueDebounced(
                              currentCustomProgram!.id,
                              muscle,
                              muscleData.muscleId!,
                              int.parse(newValue),
                              muscleData.isActive!,
                            );
                      }
                    }

                    if (mode == MuscleFormMode.active && isEditMode) {
                      context
                          .read<ProgramMusclesCubit>()
                          .updateMuscleValueDebounced(
                            currentCustomProgram!.id,
                            muscle,
                            muscleData.muscleId!,
                            muscleData.value!.toInt(),
                            newValue as bool,
                          );
                    }
                  },
                ),
              );
            }),
          );
        });
      },
    );
  }
}
