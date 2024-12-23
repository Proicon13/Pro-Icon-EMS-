import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/utils/enums/role.dart';
import '../cubit/cubit/select_role_cubit.dart';
import 'role_card.dart';

class UserTypesBlocBuilder extends StatelessWidget {
  const UserTypesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocSelector<SelectRoleCubit, SelectRoleState, bool>(
            selector: (state) => state.role == Role.admin,
            builder: (context, isSelected) {
              return RoleCard(
                isSelected: isSelected,
                title: "roleSelection.adminRole".tr(),
                imagePath: Assets.assetsImagesAdmin,
                onTap: () {
                  BlocProvider.of<SelectRoleCubit>(context)
                      .selectRole(Role.admin);
                },
              );
            },
          ),
        ),
        20.w.horizontalSpace,
        Expanded(
          child: BlocSelector<SelectRoleCubit, SelectRoleState, bool>(
            selector: (state) => state.role == Role.coach,
            builder: (context, isSelected) {
              return RoleCard(
                isSelected: isSelected,
                title: "roleSelection.trainerRole".tr(),
                imagePath: Assets.assetsImagesTrainer,
                onTap: () {
                  BlocProvider.of<SelectRoleCubit>(context)
                      .selectRole(Role.coach);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
