import 'package:flutter/material.dart';

extension SizeHelperExtension on BuildContext {
  double get height => isLandscape
      ? MediaQuery.of(this).size.width
      : MediaQuery.of(this).size.height;
  double get width => isLandscape
      ? MediaQuery.of(this).size.height
      : MediaQuery.of(this).size.width;
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
}
