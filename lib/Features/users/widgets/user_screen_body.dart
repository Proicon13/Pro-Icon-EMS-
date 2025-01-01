import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Features/clients/add_client/screens/add_client_screen.dart';
import 'package:pro_icon/Features/manage_trainer/screens/manage_trainer_screen.dart';
import 'package:pro_icon/Features/users/screens/users_screen.dart';
import 'package:pro_icon/Features/users/widgets/filter_dialog.dart';
import 'package:pro_icon/Features/users/widgets/search_section.dart';

import '../../../Core/utils/responsive_helper/size_constants.dart';
import '../cubits/user_managment_cubit.dart';
import 'user_variation_section.dart';
import 'users_list_section.dart';

class UsersScreenBody extends StatelessWidget {
  const UsersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UserManagmentCubit>(context, listen: false);

    return Padding(
        padding: SizeConstants.kScaffoldPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.setMinSize(40).verticalSpace,
            UserVariationSection(
              cubit: cubit,
            ),
            context.setMinSize(50).verticalSpace,
            SearchSection(
              onSearch: (query) {
                if (query.isEmpty) {
                  // if search field is empty then close search mode
                  cubit.toggleIsSearching(false);
                } else {
                  cubit.onSearch(query);
                }
              },
              onFilterPressed: () {
                // if not loading then show filter dialog
                if (cubit.state.requestStatus == RequestStatus.loading) return;

                showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                        value: cubit, child: const FilterDialog());
                  },
                );
              },
              onAddPressed: () {
                // if not loading then navigate to add user screen
                if (cubit.state.requestStatus == RequestStatus.loading) return;

                if (cubit.state.currentVariation == UserVariations.trainer) {
                  Navigator.pushNamed(context, ManageTrainerScreen.routeName);
                } else {
                  Navigator.pushNamed(context, AddClientScreen.routeName,
                      arguments: UsersScreen.routeName);
                }
              },
            ),
            context.setMinSize(30).verticalSpace,
            const UsersListSection(),
          ],
        ));
  }
}
