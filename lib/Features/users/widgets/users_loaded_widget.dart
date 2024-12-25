import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/widgets/empty_state_widget.dart';
import 'package:pro_icon/Features/users/widgets/user_card.dart';

import '../../../data/models/app_user_model.dart';
import '../cubits/user_managment_cubit.dart';

class UsersListLoadedWidget extends StatelessWidget {
  final UserManagmentState state;

  const UsersListLoadedWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final emptyStateMessage = _getEmptyStateMessage(state);

    final List<AppUserModel> users = state.isSearching!
        ? state.searchList!
        : (state.currentVariation == UserVariations.trainer
            ? state.trainers!
            : state.clients!);

    return Expanded(
      child: emptyStateMessage != null
          ? SingleChildScrollView(
              child: SizedBox(
                height: 0.55.sh,
                child: Center(
                  child: EmptyStateWidget(message: emptyStateMessage),
                ),
              ),
            )
          : AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: ListView.builder(
                key: ValueKey(state.currentVariation),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final AppUserModel user = users[index];
                  return UserCardLoaded(
                    key: ValueKey(user.id),
                    user: user,
                    onTap: () {
                      // Handle user card tap
                    },
                    onEdit: () {
                      // navigate to edit user screen
                    },
                    onDelete: () {
                      // delete user
                    },
                  );
                },
              ),
            ),
    );
  }

  String? _getEmptyStateMessage(UserManagmentState state) {
    if (state.isSearching! && state.searchList!.isEmpty) {
      return 'No search results Found';
    }

    final variationMessages = {
      UserVariations.trainer: 'No Trainers Found',
      UserVariations.client: 'No Clients Found',
    };

    if (!state.isSearching!) {
      if (state.currentVariation == UserVariations.trainer &&
          state.trainers!.isEmpty) {
        return variationMessages[UserVariations.trainer];
      }
      if (state.currentVariation == UserVariations.client &&
          state.clients!.isEmpty) {
        return variationMessages[UserVariations.client];
      }
    }

    return null;
  }
}
