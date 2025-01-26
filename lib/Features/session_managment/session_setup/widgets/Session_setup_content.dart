import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Features/session_managment/control_panel/screens/control_panel_screen.dart';
import 'package:pro_icon/Features/session_managment/session_setup/widgets/select_category_widget.dart';
import 'package:pro_icon/Features/session_managment/session_setup/widgets/select_program_widget.dart';

import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/utils/responsive_helper/size_constants.dart';
import '../../../../Core/widgets/base_app_Scaffold.dart';
import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/custom_header.dart';
import '../cubits/cubit/session_setup_cubit.dart';
import '../cubits/cubit/session_setup_state.dart';
import 'mode_cards.dart';

class SessionSetupContent extends StatelessWidget {
  const SessionSetupContent({super.key});

  void _handleButtonPress(BuildContext context) {
    final cubit = context.read<SessionCubit>();
    if (cubit.state.selectedSessionMode == SessionControlMode.program &&
        (cubit.state.selectedProgram?.name.isEmpty ?? true)) {
      return buildCustomAlert(context, "Please select a program", Colors.red);
    } else if (cubit.state.selectedSessionMode == SessionControlMode.auto &&
        (cubit.state.selectedAutomaticSession?.name == null)) {
      return buildCustomAlert(context, "Please select a session", Colors.red);
    }

    if (cubit.state.selectedSessionMode == SessionControlMode.auto) {
      Navigator.pushReplacementNamed(context, ControlPanelScreen.routeName,
          arguments: [
            SessionControlMode.auto,
            null,
            cubit.state.selectedAutomaticSession,
            null
          ]);
    } else {
      Navigator.pushReplacementNamed(context, ControlPanelScreen.routeName,
          arguments: [
            SessionControlMode.program,
            cubit.state.selectedProgram,
            null,
            cubit.state.allPrograms
          ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      body: Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          children: [
            context.setMinSize(25).verticalSpace,
            const CustomHeader(titleKey: "Session management"),
            context.setMinSize(100).verticalSpace,
            BlocListener<SessionCubit, SessionState>(
              listener: (context, state) {
                if (state.errorMessage != null &&
                    state.errorMessage!.isNotEmpty) {
                  buildCustomAlert(context, state.errorMessage!, Colors.red);
                }
              },
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Set session mode',
                      style: AppTextStyles.fontSize18(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    context.setMinSize(20).verticalSpace,
                    const ModeCards(),
                    context.setMinSize(40).verticalSpace,
                    const SelectCategoryWidget(),
                    context.setMinSize(20).verticalSpace,
                    const SelectProgramWidget(),
                    const Spacer(), // Pushes the button to the bottom
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        onPressed: () => _handleButtonPress(context),
                        text: "Next",
                      ),
                    ),
                    context.setMinSize(20).verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
