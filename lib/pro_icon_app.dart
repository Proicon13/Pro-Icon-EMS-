import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'Core/constants/app_constants.dart';
import 'Core/cubits/user_state/user_state_cubit.dart';
import 'Core/dependencies.dart';
import 'Core/routing/app_router.dart';
import 'Core/routing/router_observer.dart';
import 'Core/theme/app_theme.dart';
import 'Features/users/widgets/size_config_wrapper.dart';

class Proicon extends StatelessWidget {
  const Proicon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserStateCubit>(
            create: (context) => getIt<UserStateCubit>())
      ],
      child: SizeConfigWrapper(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppTheme.appTheme,
            navigatorObservers: [MyNavigatorObserver()],
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            localizationsDelegates: [
              FormBuilderLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              ...context.localizationDelegates,
            ],
            onGenerateRoute: onGenerteRoute,
            initialRoute: "/"),
      ),
    );
  }
}
