// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';

class BaseAppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidButtomPadding;

  const BaseAppScaffold(
      {super.key,
      this.body,
      this.bottomNavigationBar,
      this.resizeToAvoidButtomPadding});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: body,
        resizeToAvoidBottomInset: resizeToAvoidButtomPadding,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
