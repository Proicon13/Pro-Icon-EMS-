import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/entities/program_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_button.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';
import 'package:pro_icon/Features/session_managment/control_panel/cubits/cubit/control_panel_cubit.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/select_program_dialog.dart';
import 'package:pro_icon/Features/session_managment/session_setup/cubits/cubit/session_setup_state.dart';

import '../../../../Core/constants/app_assets.dart';
import 'control_panel_program_card.dart';

class ProgramInfoSection extends StatelessWidget {
  const ProgramInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConstants.kScaffoldPadding(context),
      child: BlocBuilder<ControlPanelCubit, ControlPanelState>(
        builder: (context, state) {
          if (state.isError) {
            return const SizedBox.shrink();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.sizeConfig.width,
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
                    if (state.selectedSessionMode != SessionControlMode.auto)
                      _buildProgramModeView(state),
                    (context.screenWidth * 0.15).horizontalSpace,
                    SizedBox(
                      width: context.setMinSize(90),
                      child: CustomButton(
                        onPressed: () {
                          //TODO: handle group mads functionality
                        },
                        text: "Group",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
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
                print("Tapped");
                showDialog(
                  context: context,
                  builder: (context) {
                    return SelectProgramDialog(
                      programs: state.allPrograms,
                      onProgramSelected: (program) {
                        Navigator.pop(context);
                        ctx
                            .read<ControlPanelCubit>()
                            .setCurrentProgram(program);
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
