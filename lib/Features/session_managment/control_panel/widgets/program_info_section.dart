import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';
import 'package:pro_icon/Core/widgets/error_widget.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/select_program_dialog.dart';
import 'package:pro_icon/Features/session_managment/session_setup/cubits/cubit/session_setup_state.dart';
import 'package:pro_icon/data/mappers/program_entity_mapper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/theme/app_text_styles.dart';
import 'control_panel_program_card.dart';
import 'timer_card.dart';

class ProgramInfoSection extends StatelessWidget {
  const ProgramInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ControlPanelCubit>();
    return Padding(
      padding: SizeConstants.kScaffoldPadding(context),
      child: BlocBuilder<ControlPanelCubit, ControlPanelState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.errorMessage != current.errorMessage,
        builder: (context, state) {
          if (state.isError) {
            return SizedBox(
                height: context.sizeConfig.height * 0.7,
                child: Center(
                  child: CustomErrorWidget(
                    message: state.errorMessage!,
                  ),
                ));
          }
          return SizeConfig(
            baseSize: const Size(398, 150),
            width: context.setMinSize(398),
            height: context.setMinSize(150),
            child: Builder(builder: (context) {
              return Container(
                width: context.sizeConfig.width,
                height: context.sizeConfig.height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //TODO: handle reset session event
                      },
                      child: CustomSvgVisual(
                        assetPath: Assets.assetsImagesResetIcon,
                        width: context.setMinSize(40),
                        height: context.setMinSize(40),
                      ),
                    ),
                    const Spacer(),
                    state.selectedSessionMode == SessionControlMode.auto
                        ? _buildAutoModeView()
                        : _buildProgramModeView(state),
                    const Spacer(),
                    SizeConfig(
                      baseSize: const Size(90, 50),
                      width: context.setMinSize(90),
                      height: context.setMinSize(50),
                      child: Builder(builder: (context) {
                        return SizedBox(
                          width: context.sizeConfig.width,
                          child: MaterialButton(
                            height: context.sizeConfig.height,
                            onPressed: () {
                              cubit.onGroupModeToggle(!state.isGroupMode);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  SizeConstants.kDefaultBorderRadius(context),
                            ),
                            color: AppColors.primaryColor,
                            child: Text("Group",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: context.setSp(15),
                                )),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildAutoModeView() {
    return BlocBuilder<ControlPanelCubit, ControlPanelState>(
      buildWhen: (previous, current) =>
          previous.currentProgramIndex != current.currentProgramIndex ||
          previous.isProgramTransitioning != current.isProgramTransitioning ||
          previous.currentProgramDuration != current.currentProgramDuration,
      builder: (context, state) {
        if (state.automaticSessionprograms == null ||
            state.automaticSessionprograms!.isEmpty) {
          return const SizedBox.shrink();
        }

        final currentProgram =
            state.automaticSessionprograms![state.currentProgramIndex];
        final nextProgramIndex = state.currentProgramIndex + 1;
        final nextProgram =
            nextProgramIndex < state.automaticSessionprograms!.length
                ? state.automaticSessionprograms![nextProgramIndex]
                : null;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (nextProgram != null) // Show next program only if available
              Column(
                children: [
                  Container(
                    child: Opacity(
                      opacity: 0.7,
                      child: SizeConfig(
                        baseSize: const Size(100, 115),
                        width: context.setMinSize(100),
                        height: context.setMinSize(115),
                        child: ControlPanelProgramCard(
                            program:
                                ProgramModelToEntityMapper.mapFromProgramModel(
                                    nextProgram.program!)),
                      ),
                    ),
                  ),
                  state.isProgramTransitioning
                      ? TimerCard(
                          size: context.setMinSize(30), // Small timer size
                          isRed: true,
                          value:
                              state.currentProgramDuration.inSeconds.toString(),
                          textStyle: AppTextStyles.fontSize12(context).copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          currentValue: state.currentProgramDuration.inSeconds,
                          fullValue: 15,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            nextProgram != null
                ? context.setMinSize(10).horizontalSpace
                : context
                    .setMinSize(110)
                    .horizontalSpace, // Spacing between cards
            if (nextProgram != null)
              Container(
                margin: EdgeInsets.only(top: context.setMinSize(10)),
                child: Icon(Icons.arrow_forward,
                    color: Colors.white, size: context.setMinSize(24)),
              ),
            nextProgram != null
                ? context.setMinSize(10).horizontalSpace
                : const SizedBox.shrink(),
            SizeConfig(
              baseSize: const Size(120, 140),
              width: context.setMinSize(120),
              height: context.setMinSize(140),
              child: Builder(builder: (context) {
                return ControlPanelProgramCard(
                    program: ProgramModelToEntityMapper.mapFromProgramModel(
                        currentProgram.program!));
              }),
            ), // Current program card
          ],
        );
      },
    );
  }

  Widget _buildProgramModeView(ControlPanelState state) {
    return BlocSelector<ControlPanelCubit, ControlPanelState, ProgramEntity>(
      selector: (state) {
        return state.selectedProgram!;
      },
      builder: (ctx, program) {
        return SizeConfig(
          baseSize: const Size(120, 140),
          width: ctx.setMinSize(120),
          height: ctx.setMinSize(140),
          child: Builder(builder: (context) {
            return ControlPanelProgramCard(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SelectProgramDialog(
                      programs: state.allPrograms,
                      onProgramSelected: (program) {
                        Navigator.pop(context);
                        ctx
                            .read<ControlPanelCubit>()
                            .onProgramSelected(program);
                      },
                    );
                  },
                );
              },
              program: program,
            );
          }),
        );
      },
    );
  }
}
