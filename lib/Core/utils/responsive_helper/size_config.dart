import 'package:flutter/material.dart';

class SizeConfig extends InheritedWidget {
  final Size baseSize;
  final double width;
  final double height;

  static SizeConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SizeConfig>()!;
  }

  SizeConfig(
      {super.key,
      required super.child,
      required this.baseSize,
      required this.width,
      required this.height});
  @override
  bool updateShouldNotify(covariant SizeConfig oldWidget) {
    return baseSize != oldWidget.baseSize ||
        width != oldWidget.width ||
        height != oldWidget.height ||
        child != oldWidget.child;
  }
}
