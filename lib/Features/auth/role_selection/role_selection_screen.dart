import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';

import '../../../../../Core/Theming/app_text_styles.dart';
import '../../../../../Core/constants/app_assets.dart';
import '../../../../../Core/widgets/custom_button.dart';
import '../../../../../Core/widgets/custom_asset_image.dart';
import '../../../../../Core/utils/enums/role.dart';
import 'cubit/cubit/select_role_cubit.dart';
import 'widgets/role_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  static const routeName = '/role-case';

  const RoleSelectionScreen({super.key});

  void navigateBasedOnRole(BuildContext context, Role? selectedRole) {
    if (selectedRole == Role.admin) {
      // Navigate to Admin page
      Navigator.pushReplacementNamed(context, '/admin');
    } else if (selectedRole == Role.coach) {
      // Navigate to Trainer page
      Navigator.pushReplacementNamed(context, '/trainer');
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
      lazy: true,
      create: (context) => getIt<SelectRoleCubit>(),
      child: BaseAppScaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              90.h.verticalSpace,
              Center(
                child: SizedBox(
                  width: 200.w,
                  child: AspectRatio(
                    aspectRatio: 200.w / 60.h,
                    child: const CustomAssetImage(
                      path: Assets.assetsImagesLogo,
                    ),
                  ),
                ),
              ),
              50.h.verticalSpace,
              Text(
                "Select User Type",
                style: AppTextStyles.fontSize24.copyWith(color: Colors.white),
              ),
              25.h.verticalSpace,
              Text(
                'Tell us about yourself so we can get better experience for you',
                textAlign: TextAlign.left,
                style: AppTextStyles.fontSize14.copyWith(color: Colors.white),
              ),
              60.h.verticalSpace,
              BlocSelector<SelectRoleCubit, SelectRoleState, Role?>(
                selector: (state) => state.role,
                builder: (context, selectedRole) {
                  return Row(
                    children: [
                      Expanded(
                        child: RoleCard(
                          isSelected: selectedRole == Role.admin,
                          title: "Admin",
                          imagePath: Assets.assetsImagesAdmin,
                          onTap: () {
                            BlocProvider.of<SelectRoleCubit>(context)
                                .selectRole(Role.admin);
                          },
                        ),
                      ),
                      20.w.horizontalSpace,
                      Expanded(
                        child: RoleCard(
                          isSelected: selectedRole == Role.coach,
                          title: "Trainer",
                          imagePath: Assets.assetsImagesTrainer,
                          onTap: () {
                            BlocProvider.of<SelectRoleCubit>(context)
                                .selectRole(Role.coach);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
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
