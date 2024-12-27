import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Core/widgets/title_section.dart';

import '../../../../../../Core/utils/enums/role.dart';
import '../../../../../../Core/widgets/custom_button.dart';
import '../../../../Core/widgets/pro_icon_logo.dart';
import '../../login/screens/login_screen.dart';
import '../cubit/cubit/select_role_cubit.dart';
import '../widgets/user_type_bloc_selector.dart';

class RoleSelectionScreen extends StatelessWidget {
  static const routeName = '/role-case';

  const RoleSelectionScreen({super.key});

  void navigateBasedOnRole(BuildContext context, Role? selectedRole) {
    if (selectedRole == Role.admin || selectedRole == Role.coach) {
      // Navigate to Login Screen
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else {
      // If no role is selected
      buildCustomAlert(
          context, "roleSelection.screen.message".tr(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SelectRoleCubit>(),
      child: BaseAppScaffold(
        body: Padding(
          padding: SizeConstants.kBottomNavBarPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.setMinSize(90).verticalSpace,
              const Center(
                child: ProIconLogo(),
              ),
              context.setMinSize(50).verticalSpace,
              TitleSection(
                  title: "roleSelection.title".tr(),
                  subtitle: "roleSelection.subtitle".tr()),
              context.setMinSize(60).verticalSpace,
              const UserTypesBlocBuilder(),
              const Spacer(),
              BlocSelector<SelectRoleCubit, SelectRoleState, Role?>(
                selector: (state) => state.role,
                builder: (context, selectedRole) {
                  return SizeConfig(
                    baseSize: const Size(398, 50),
                    height: context.setMinSize(50),
                    width: context.setMinSize(398),
                    child: Builder(builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        height: context.sizeConfig.height,
                        child: CustomButton(
                          text: "next".tr(),
                          onPressed: () =>
                              navigateBasedOnRole(context, selectedRole),
                        ),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
