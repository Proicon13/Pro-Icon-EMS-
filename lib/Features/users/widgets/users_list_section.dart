import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/widgets/custom_snack_bar.dart';
import 'package:pro_icon/Features/users/cubits/user_managment_cubit.dart';

import 'users_loaded_widget.dart';
import 'users_loading_widget.dart';

class UsersListSection extends StatelessWidget {
  const UsersListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserManagmentCubit, UserManagmentState>(
      listenWhen: (previous, current) =>
          previous.requestStatus != current.requestStatus,
      listener: (context, state) {
        if (state.requestStatus == RequestStatus.error) {
          buildCustomAlert(context, state.errorMessage!, Colors.red);
        }
      },
      buildWhen: (previous, current) =>
          previous.requestStatus != current.requestStatus ||
          previous.isSearching != current.isSearching,
      builder: (context, state) {
        if (state.requestStatus == RequestStatus.loading) {
          return const UsersListLoadingWidget();
        } else if (state.requestStatus == RequestStatus.loaded) {
          return UsersListLoadedWidget(state: state);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
