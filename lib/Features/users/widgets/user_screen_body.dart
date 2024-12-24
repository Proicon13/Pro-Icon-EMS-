import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Features/users/cubits/user_managment_cubit.dart';
import 'package:pro_icon/Features/users/widgets/search_section.dart';

import 'user_variation_section.dart';

class UsersScreenBody extends StatelessWidget {
  const UsersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserManagmentCubit>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          40.h.verticalSpace,
          UserVariationSection(cubit: cubit),
          50.h.verticalSpace,
          SearchSection(
              onSearch: (value) {},
              onFilterPressed: () {},
              onAddPressed: () {}),
        ],
      ),
    );
  }
}
