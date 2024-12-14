import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/utils/enums/role.dart';
import '../cubit/cubit/select_role_cubit.dart';
import 'role_card.dart';

class UserTypesBlocSelector extends StatelessWidget {
  const UserTypesBlocSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SelectRoleCubit, SelectRoleState, Role?>(
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
    );
  }
}
