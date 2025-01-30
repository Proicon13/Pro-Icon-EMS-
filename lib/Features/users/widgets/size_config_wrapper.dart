import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';

class SizeConfigWrapper extends StatelessWidget {
  final Widget child;
  const SizeConfigWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      child: child,
      baseSize: const Size(430, 932),
      height: context.screenHeight,
      width: context.screenWidth,
    );
  }
}
