import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Features/automatic_sessions/cubits/auto_sessions_cubit.dart';
import 'package:pro_icon/Features/automatic_sessions/cubits/custom_auto_session_cubit.dart';
import 'package:pro_icon/Features/automatic_sessions/cubits/main_auto_session_cubit.dart';

import '../../../Core/dependencies.dart';
import '../widgets/auto_sessions_view_body.dart';

class AutoSessionsView extends StatelessWidget {
  const AutoSessionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AutoSessionsCubit>(
          create: (context) => getIt<AutoSessionsCubit>(),
        ),
        BlocProvider<MainAutoSessionCubit>(
          create: (context) => getIt<MainAutoSessionCubit>()
            ..fetchMainSessions(isFirstFetch: true),
        ),
        BlocProvider<CustomAutoSessionCubit>(
          create: (context) => getIt<CustomAutoSessionCubit>(),
        ),
      ],
      child: const AutoSessionsViewBody(),
    );
  }
}
