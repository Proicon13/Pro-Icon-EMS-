import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/title_section.dart';

import '../../../../../Core/widgets/custom_button.dart';

import '../../../../../Core/utils/enums/role.dart';
import '../../../Core/widgets/pro_icon_logo.dart';
import '../login/login_screen.dart';
import 'cubit/cubit/select_role_cubit.dart';

import 'widgets/user_type_bloc_selector.dart';

class RoleSelectionScreen extends StatelessWidget {
  static const routeName = '/role-case';

  const RoleSelectionScreen({super.key});

  void navigateBasedOnRole(BuildContext context, Role? selectedRole) {
    if (selectedRole == Role.admin || selectedRole == Role.coach) {
      // Navigate to Login Screen
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } else {
      // If no role is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a role"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SelectRoleCubit>(),
      child: BaseAppScaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              90.h.verticalSpace,
              const Center(
                child: ProIconLogo(),
              ),
              50.h.verticalSpace,
              const TitleSection(
                  title: "Select User Type",
                  subtitle:
                      'Tell us about yourself so we can get better experience for you'),
              60.h.verticalSpace,
              const UserTypesBlocSelector(),
              const Spacer(),
              BlocSelector<SelectRoleCubit, SelectRoleState, Role?>(
                selector: (state) => state.role,
                builder: (context, selectedRole) {
                  return SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Next",
                      onPressed: () =>
                          navigateBasedOnRole(context, selectedRole),
                    ),
                  );
                },
              ),
              30.h.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
