import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pro_icon/Core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Core/routing/app_router.dart';
import 'Core/theme/app_theme.dart';

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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: AppTheme.appTheme,
          supportedLocales: FormBuilderLocalizations.supportedLocales,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            FormBuilderLocalizations.delegate,
          ],
          onGenerateRoute: onGenerteRoute,
        );
      },
    );
  }
}
