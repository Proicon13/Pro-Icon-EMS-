import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/widgets/custom_loader.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';
import '../../../clients/add_client/cubits/cubit/client_registration_cubit.dart';
import '../cubits/cubit/manage_custom_program_cubit.dart';
import '../cubits/cubit/program_muscles_cubit.dart';
import 'muscle_form_section.dart';
import 'muscles_grid_widget.dart';

class MusclesListSection extends StatelessWidget {
  const MusclesListSection({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.manageProgramCubit,
    required this.mode,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;
  final ManageCustomProgramCubit manageProgramCubit;
  final MuscleFormMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgramMusclesCubit, ProgramMusclesState>(
      buildWhen: (previous, current) =>
          previous.musclesRequestStatus != current.musclesRequestStatus,
      listener: (context, state) {
        if (state.musclesRequestStatus == RequestStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
      },
      builder: (context, state) {
        if (state.musclesRequestStatus == ProgramMusclesStatus.loading) {
          return SizedBox(
              height: context.sizeConfig.height * 0.6,
              child: const CustomLoader());
        }
        return FormBuilder(
          key: _formKey,
          child: ProgramMusclesGrid(
              programMusclesMap: state.programMuscles!,
              mode: mode,
              manageProgramCubit: manageProgramCubit),
        );
      },
    );
  }
}
