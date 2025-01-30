import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Features/session_managment/session_setup/widgets/select_category_widget.dart';
import 'package:pro_icon/Features/session_managment/session_setup/widgets/select_program_widget.dart';

import '../../../../Core/dependencies.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/utils/responsive_helper/size_constants.dart';
import '../../../../Core/widgets/base_app_Scaffold.dart';
import '../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/custom_header.dart';
import '../../session_summary/screen/session_summary.dart';
import '../cubits/cubit/session_setup_cubit.dart';
import 'mode_cards.dart';

class SessionSetupContent extends StatelessWidget {
  const SessionSetupContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionCubit>(
      create: (context) =>
          getIt<SessionCubit>()..getSessionManagementCategories(),
      child: BaseAppScaffold(
        body: Padding(
          padding: SizeConstants.kScaffoldPadding(context),
          child: Column(
            children: [
              context.setMinSize(25).verticalSpace,
              const CustomHeader(titleKey: "Session management"),
              context.setMinSize(120).verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Set session mode',
                    style: AppTextStyles.fontSize16(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  context.setMinSize(10).verticalSpace,
                  ModeCards(),
                  context.setMinSize(40).verticalSpace,
                  const SelectCategoryWidget(),
                  context.setMinSize(20).verticalSpace,
                  const SelectProgramWidget(),
                  context.setMinSize(30).verticalSpace,
                  CustomButton(onPressed: () {
                    Navigator.pushNamed(context, SessionSummary.routeName);
                  }, text: "Next"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
