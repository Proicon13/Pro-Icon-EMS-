// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../constants/app_assets.dart';

class BaseAppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;

  const BaseAppScaffold({super.key, this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.assetsImagesSplash),
                  fit: BoxFit.cover)),
          child: body,
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
