import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Features/automatic_sessions/manage_session/cubits/cubit/manage_custom_session_cubit.dart';
import 'package:pro_icon/Features/automatic_sessions/manage_session/widgets/editable_session_program_card.dart';
import 'package:pro_icon/data/models/auto_session_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_dropdown_section.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';

class SessionProgramsSection extends StatelessWidget {
  const SessionProgramsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageCustomSessionCubit>();
    return Column(
      children: [
        _buildProgramsDropDown(cubit),
        context.setMinSize(20).verticalSpace,
        _buildSessionProgramsList(cubit)
      ],
    );
  }

  Widget _buildSessionProgramsList(ManageCustomSessionCubit cubit) {
    return BlocSelector<ManageCustomSessionCubit, ManageCustomSessionState,
        List<SessionProgram>>(
      selector: (state) {
        return state.sessionPrograms;
      },
      builder: (context, programs) {
        if (programs.isEmpty) return const SizedBox.shrink();
        return ReorderableListView.builder(
            shrinkWrap: true,
            proxyDecorator: (child, index, animation) {
              // Return the same child to remove the long press effect
              return child;
            },
            onReorder: (oldIndex, newIndex) {
              cubit.onReorderProgram(oldIndex, newIndex);
            },
            itemBuilder: (context, index) {
              final program = programs[index];

              return SizeConfig(
                key: Key(index.toString()),
                baseSize: const Size(398, 95),
                width: context.setMinSize(398),
                height: context.setMinSize(95),
                child: Builder(builder: (context) {
                  return EditableSessionProgramCard(
                      sessionProgram: program,
                      onRemove: () {
                        cubit.onDeleteSessionProgram(program);
                      },
                      onDurationIncrease: () {
                        cubit.onDurationChange(program, true);
                      },
                      onDurationDecrease: () {
                        cubit.onDurationChange(program, false);
                      },
                      onPulseIncrease: () {
                        cubit.onPulseChange(program, true);
                      },
                      onPulseDecrease: () {
                        cubit.onPulseChange(program, false);
                      });
                }),
              );
            },
            itemCount: programs.length);
      },
    );
  }

  Widget _buildProgramsDropDown(ManageCustomSessionCubit cubit) {
    return BlocConsumer<ManageCustomSessionCubit, ManageCustomSessionState>(
      listenWhen: (previous, current) =>
          previous.getProgramsStatus != current.getProgramsStatus,
      listener: (context, state) {
        if (state.getProgramsStatus == ManageCustomSessionStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
      },
      buildWhen: (previous, current) =>
          previous.getProgramsStatus != current.getProgramsStatus,
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.getProgramsStatus == ManageCustomSessionStatus.loading,
          child: DropdownFormSection<ProgramEntity>(
            title: "Programs",
            name: state.getProgramsStatus == ManageCustomSessionStatus.loading
                ? ""
                : "programs",
            initialValue: state.programs.isEmpty ? null : state.programs.first,
            onChanged: (program) {
              if (program != null) {
                context
                    .read<ManageCustomSessionCubit>()
                    .onProgramSelected(program);
              }
            },
            items: state.programs
                .map((program) => DropdownMenuItem<ProgramEntity>(
                      value: program,
                      child: Text(
                        program.name,
                        style: AppTextStyles.fontSize14(context).copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ))
                .toList(),
            hintText: "Select Program",
          ),
        );
      },
    );
  }
}
