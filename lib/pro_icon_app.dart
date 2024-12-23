import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/cubits/cubit/user_state_cubit.dart';
import 'package:pro_icon/Core/dependencies.dart';

import 'Core/constants/app_constants.dart';
import 'Core/routing/app_router.dart';
import 'Core/theme/app_theme.dart';
import 'splash_screen.dart';

class Proicon extends StatelessWidget {
  const Proicon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<UserStateCubit>(
                create: (context) => getIt<UserStateCubit>())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppTheme.appTheme,
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
            initialRoute: SplashScreen.routeName,
          ),
        );
      },
    );
  }
}
