import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/widgets/keyboard_dismissable.dart';
import '../cubits/user_managment_cubit.dart';
import 'user_screen_body.dart';

class UsersScreenScaffold extends StatelessWidget {
  const UsersScreenScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissable(
      onDismiss: () {
        // when un focus search field untrigger search mode
        FocusManager.instance.primaryFocus?.unfocus();
        BlocProvider.of<UserManagmentCubit>(context).toggleIsSearching(false);
      },
      child: const UsersScreenBody(),
    );
  }
}
