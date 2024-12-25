import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/user_managment_cubit.dart';
import 'user_variation_column.dart';

class UserVariationSection extends StatelessWidget {
  final UserManagmentCubit cubit;
  UserVariationSection({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocSelector<UserManagmentCubit, UserManagmentState, bool>(
          selector: (state) => state.currentVariation == UserVariations.trainer,
          builder: (context, state) {
            return UserVariationColumn(
              onTap: () => cubit.toggleVariation(UserVariations.trainer),
              isSelected: state,
              userVariation: "userManagment.screen.trainers".tr(),
            );
          },
        ),
        40.w.horizontalSpace,
        BlocSelector<UserManagmentCubit, UserManagmentState, bool>(
          selector: (state) => state.currentVariation == UserVariations.client,
          builder: (context, state) {
            return UserVariationColumn(
              onTap: () => cubit.toggleVariation(UserVariations.client),
              isSelected: state,
              userVariation: "userManagment.screen.clients".tr(),
            );
          },
        ),
      ],
    );
  }
}
