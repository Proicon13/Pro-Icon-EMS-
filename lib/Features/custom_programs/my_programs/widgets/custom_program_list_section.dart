import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/custom_confirmation_dialog.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/program_card.dart';
import 'package:pro_icon/Features/custom_programs/my_programs/cubits/cubit/my_programs_cubit.dart';

import '../../../../Core/cubits/user_state/user_state_cubit.dart';
import '../../../../Core/entities/program_entity.dart';
import '../../../../Core/entities/programmer_entity.dart';
import '../../../../Core/widgets/custom_snack_bar.dart';
import '../../../../Core/widgets/empty_state_widget.dart';
import '../../manage_program/screens/manage_custom_program_screen.dart';

class CustomProgramSection extends StatelessWidget {
  const CustomProgramSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyProgramsCubit, MyProgramsState>(
      listenWhen: (previous, current) =>
          previous.deleteRequestStatus != current.deleteRequestStatus,
      listener: (context, state) {
        if (state.deleteRequestStatus == MyProgramsStatus.success) {
          buildCustomAlert(context, state.message!, Colors.green);
        }
        if (state.deleteRequestStatus == MyProgramsStatus.error) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
      },
      child: BlocSelector<UserStateCubit, UserStateState, List<ProgramEntity>>(
        selector: (state) {
          return (state.currentUser as ProgrammerEntity).customPrograms!;
        },
        builder: (context, state) {
          if (state.isEmpty) return _buildEmptyState();
          return _buildProgramsList(state);
        },
      ),
    );
  }

  Expanded _buildEmptyState() {
    return const Expanded(child: EmptyStateWidget(message: "No Programs yet"));
  }

  Expanded _buildProgramsList(List<ProgramEntity> state) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            context.setMinSize(20).verticalSpace,
        itemCount: state.length,
        itemBuilder: (mainContext, index) {
          final program = state[index];
          return SizeConfig(
            baseSize: const Size(398, 175),
            width: mainContext.setMinSize(398),
            height: mainContext.setMinSize(130),
            child: Builder(builder: (context) {
              return ProgramCardWithActions(
                program: program,
                onEdit: () {
                  Navigator.pushNamed(
                      context, ManageCustomProgramScreen.routeName,
                      arguments: program);
                },
                onDelete: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CustomConfirmationDialog(
                            title:
                                "Are you sure you want to delete this program?",
                            confirmationTitle: "Yes, Delete",
                            onConfirm: () {
                              Navigator.pop(context);
                              mainContext.read<MyProgramsCubit>().deleteProgram(
                                  id: program.id, programIndex: index);
                            });
                      });
                },
              );
            }),
          );
        },
      ),
    );
  }
}
