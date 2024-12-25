import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/widgets/base_app_scaffold.dart';
import '../../../Core/widgets/custom_app_bar.dart';
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
        FocusManager.instance.primaryFocus?.unfocus();
        BlocProvider.of<UserManagmentCubit>(context).toggleIsSearching(false);
      },
      child: BaseAppScaffold(
        appBar: CustomAppBar(
          titleKey: "userManagment.screen.title".tr(),
        ),
        body: const UsersScreenBody(),
      ),
    );
  }
}
