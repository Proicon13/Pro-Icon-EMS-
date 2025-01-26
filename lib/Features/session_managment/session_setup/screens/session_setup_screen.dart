import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Features/session_managment/session_setup/widgets/Session_setup_content.dart';

import '../../../../Core/dependencies.dart';
import '../cubits/cubit/session_setup_cubit.dart';

class SessionSetupScreen extends StatelessWidget {
  static const routeName = '/session_setup';
  const SessionSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionCubit>(
      create: (context) =>
          getIt<SessionCubit>()..getSessionManagementCategories(),
      child: const SessionSetupContent(),
    );
  }
}
