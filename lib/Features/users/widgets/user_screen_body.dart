import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Features/users/widgets/search_section.dart';

import '../cubits/user_managment_cubit.dart';
import 'user_variation_section.dart';
import 'users_list_section.dart';

class UsersScreenBody extends StatelessWidget {
  const UsersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    log("built users screen body");
    final cubit = BlocProvider.of<UserManagmentCubit>(context, listen: false);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            UserVariationSection(
              cubit: cubit,
            ),
            SizedBox(height: 50.h),
            SearchSection(
              onSearch: (value) {
                if (value.isNotEmpty) {
                  cubit.onSearch(value);
                }
              },
              onFilterPressed: () {
                // if not loading then show filter dialog
                if (cubit.state.requestStatus != RequestStatus.loading) {
                  return;
                }
              },
              onAddPressed: () {
                // if not loading then navigate to add user screen
                if (cubit.state.requestStatus != RequestStatus.loading) {
                  return;
                }
              },
            ),
            SizedBox(height: 30.h),
            const UsersListSection(),
          ],
        ));
  }
}
