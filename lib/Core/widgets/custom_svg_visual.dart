import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgVisual extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  const CustomSvgVisual({
    Key? key,
    required this.assetPath,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
