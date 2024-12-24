import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Features/users/cubits/user_managment_cubit.dart';

import 'loaded_state_widget.dart';
import 'loading_state_widget.dart';

class UsersListSection extends StatelessWidget {
  const UsersListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagmentCubit, UserManagmentState>(
      buildWhen: (previous, current) =>
          previous.requestStatus != current.requestStatus,
      builder: (context, state) {
        if (state.requestStatus == RequestStatus.loading) {
          return const LoadingStateWidget();
        } else if (state.requestStatus == RequestStatus.loaded) {
          return LoadedStateWidget(state: state);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
