import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';

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
        BlocSelector<SelectRoleCubit, SelectRoleState, bool>(
          selector: (state) => state.role == Role.admin,
          builder: (context, isSelected) {
            log("role card width: ${context.screenWidth}");
            log("role card height: ${context.screenHeight}");
            return SizeConfig(
              baseSize: const Size(180, 200),
              width: context.setMinSize(180),
              height: context.setMinSize(200),
              child: Builder(builder: (context) {
                log("role card width: ${context.sizeConfig.width}");
                log("role card height: ${context.sizeConfig.height}");
                return Expanded(
                  child: RoleCard(
                    isSelected: isSelected,
                    title: "roleSelection.adminRole".tr(),
                    imagePath: Assets.assetsImagesAdmin,
                    onTap: () {
                      BlocProvider.of<SelectRoleCubit>(context)
                          .selectRole(Role.admin);
                    },
                  ),
                );
              }),
            );
          },
        ),
        context.setMinSize(20).horizontalSpace,
        BlocSelector<SelectRoleCubit, SelectRoleState, bool>(
          selector: (state) => state.role == Role.coach,
          builder: (context, isSelected) {
            return SizeConfig(
              baseSize: const Size(180, 200),
              width: context.setWidth(180),
              height: context.setHeight(200),
              child: Expanded(
                child: RoleCard(
                  isSelected: isSelected,
                  title: "roleSelection.trainerRole".tr(),
                  imagePath: Assets.assetsImagesTrainer,
                  onTap: () {
                    BlocProvider.of<SelectRoleCubit>(context)
                        .selectRole(Role.coach);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
