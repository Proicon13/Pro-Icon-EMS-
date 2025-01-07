// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BaseAppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidButtomPadding;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const BaseAppScaffold(
      {super.key,
      this.body,
      this.bottomNavigationBar,
      this.resizeToAvoidButtomPadding,
      this.appBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: AppColors.backgroundColor,
        body: body,
        resizeToAvoidBottomInset: resizeToAvoidButtomPadding,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
