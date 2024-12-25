import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Features/users/cubits/user_managment_cubit.dart';

import '../../../Core/dependencies.dart';
import '../widgets/users_screen_scaffold.dart';

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
