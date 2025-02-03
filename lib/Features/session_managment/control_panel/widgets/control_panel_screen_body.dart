import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Features/custom_programs/manage_program/cubits/cubit/manage_custom_program_cubit.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/muscles_control_section.dart';
import 'package:pro_icon/Features/session_managment/control_panel/widgets/timers_control_section.dart';

import '../../../../Core/theme/app_colors.dart';
import '../../../../Core/utils/responsive_helper/size_constants.dart';
import '../../../../Core/widgets/custom_loader.dart';
import '../cubits/cubit/control_panel_cubit.dart';
import 'control_panel_header.dart';
import 'control_panel_mads_section.dart';
import 'program_info_section.dart';
import 'session_control_row.dart';

//TODO: SAVE SESSION LOGIC HANDLING
class ControlPanelScreenBody extends StatelessWidget {
  const ControlPanelScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ControlPanelCubit, ControlPanelState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.saveSessionStatus != current.saveSessionStatus,
      listener: (context, state) {
        if (state.isNotReady) {
          buildCustomAlert(context, state.errorMessage!, Colors.red);
          context.read<ControlPanelCubit>().pauseSession();
        }
        if (state.isError) {
          buildCustomAlert(context, state.errorMessage!, Colors.red);
        }
        if (state.saveSessionStatus == RequetsStatus.success) {
          buildCustomAlert(context, "Session saved successfully", Colors.green);
        }
        if (state.saveSessionStatus == RequetsStatus.error) {
          buildCustomAlert(context, state.errorMessage!, Colors.red);
        }
      },
      buildWhen: (previous, current) =>
          previous.saveSessionStatus != current.saveSessionStatus,
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state.saveSessionStatus == RequetsStatus.loading,
          blur: 0.7,
          dismissible: false,
          progressIndicator: SizeConfig(
              child: Builder(builder: (context) {
                return const SavingSessionLoader();
              }),
              baseSize: const Size(250, 250),
              width: context.setMinSize(250),
              height: context.setMinSize(250)),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: context.setMinSize(15).verticalSpace,
              ),
              const SliverToBoxAdapter(
                child: ControlPanelHeader(),
              ),
              SliverToBoxAdapter(
                child: context.setMinSize(15).verticalSpace,
              ),
              const SliverToBoxAdapter(
                child: ControlPanelMadsSection(),
              ),
              const SliverToBoxAdapter(
                child: TimersControlSection(),
              ),
              _buildDivider(state, context),
              const SliverToBoxAdapter(
                child: ProgramInfoSection(),
              ),
              const SliverToBoxAdapter(
                child: MusclesControlSection(),
              ),
              const SliverToBoxAdapter(
                child: SessionControlRow(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildDivider(ControlPanelState state, BuildContext context) {
    return BlocSelector<ControlPanelCubit, ControlPanelState, bool>(
      selector: (state) => state.isError,
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: state
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    context.setMinSize(5).verticalSpace,
                    Padding(
                      padding: SizeConstants.kScaffoldPadding(context),
                      child: Divider(
                        color: AppColors.lightGreyColor,
                        thickness: context.setMinSize(1),
                      ),
                    ),
                    context.setMinSize(5).verticalSpace
                  ],
                ),
        );
      },
    );
  }
}

class SavingSessionLoader extends StatelessWidget {
  const SavingSessionLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sizeConfig.width,
      height: context.sizeConfig.height,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(20), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(context.setMinSize(20)), // Inner padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomLoader(), // Custom loading widget
          context.setMinSize(20).verticalSpace,
          Text("Saving session...",
              style: AppTextStyles.fontSize18(context)
                  .copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
