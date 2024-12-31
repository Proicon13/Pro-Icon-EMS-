import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'user_card.dart';

class UsersListLoadingWidget extends StatelessWidget {
  const UsersListLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        enabled: true,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          child: ListView.builder(
            key: const ValueKey("loading-list"),
            itemCount: 5,
            itemBuilder: (context, index) {
              return UserCardLoading(
                key: ValueKey(index),
              );
            },
          ),
        ),
      ),
    );
  }
}
