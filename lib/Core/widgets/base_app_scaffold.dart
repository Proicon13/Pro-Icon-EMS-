// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pro_icon/Core/Theming/Colors/app_colors.dart';

import '../constants/app_assets.dart';

class BaseAppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;

  const BaseAppScaffold({super.key, this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
