import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/cubits/cubit/user_state_cubit.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'Core/routing/app_router.dart';
import 'Core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Proicon extends StatelessWidget {
  const Proicon({
    super.key,
  });

  // This widget is the root of your application.
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
            supportedLocales: [
               Locale('en', 'US')
            ],
            localizationsDelegates: const  [
              FormBuilderLocalizations.delegate,

              GlobalMaterialLocalizations.delegate,   // Required for Material widgets
              GlobalWidgetsLocalizations.delegate,    // Basic widget localization
              GlobalCupertinoLocalizations.delegate

              
              
              
              

              

              
              
            ],
            onGenerateRoute: onGenerteRoute,
          ),
        );
      },
    );
  }
}
