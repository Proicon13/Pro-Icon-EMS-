import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_app_bar.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';
import 'package:pro_icon/Features/users/cubits/user_managment_cubit.dart';

import '../../../Core/dependencies.dart';
import '../widgets/user_screen_body.dart';

class UsersScreen extends StatelessWidget {
  static const routeName = '/users-screen';
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserManagmentCubit>(
      create: (context) => getIt<UserManagmentCubit>(),
      child: const UsersScreenScaffold(),
    );
  }
}

class UsersScreenScaffold extends StatelessWidget {
  const UsersScreenScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissable(
      child: BaseAppScaffold(
        appBar: CustomAppBar(
          titleKey: "userManagment.screen.title".tr(),
        ),
        body: const UsersScreenBody(),
      ),
    );
  }
}
