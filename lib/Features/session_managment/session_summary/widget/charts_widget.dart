
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

class ChartsWidget extends StatelessWidget {
  const ChartsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseAppScaffold(
      body: Column(
        children: [
             CustomSvgVisual(assetPath: Assets.assetsSessionSummaryCharts)
        ],
      ),
    );
  }
}
