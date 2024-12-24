import 'package:flutter/material.dart';

import '../../../data/models/app_user_model.dart';
import '../cubits/user_managment_cubit.dart';
import 'user_card.dart';

class LoadedStateWidget extends StatelessWidget {
  final UserManagmentState state;

  const LoadedStateWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final emptyStateMessage = _getEmptyStateMessage(state);

    if (emptyStateMessage != null) {
      return Expanded(
        child: Center(
          child: Text(emptyStateMessage),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        key: ValueKey(state.currentVariation),
        itemCount: state.currentVariation == UserVariations.trainer
            ? state.trainers!.length
            : state.clients!.length,
        itemBuilder: (context, index) {
          final AppUserModel user =
              state.currentVariation == UserVariations.trainer
                  ? state.trainers![index]
                  : state.clients![index];
          return UserCard(
            key: ValueKey(user.id),
            user: user,
            onTap: () {},
            onEdit: () {},
            onDelete: () {},
          );
        },
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
