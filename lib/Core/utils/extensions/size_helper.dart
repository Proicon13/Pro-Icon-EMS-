import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';

extension SizeHelperExtension on BuildContext {
  double get screenHeight => isLandscape
      ? MediaQuery.sizeOf(this).width
      : MediaQuery.sizeOf(this).height;
  double get screenWidth => isLandscape
      ? MediaQuery.sizeOf(this).height
      : MediaQuery.sizeOf(this).width;
  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;
  SizeConfig get sizeConfig => SizeConfig.of(this);

  double get scaleWidth => sizeConfig.width / sizeConfig.baseSize.width;
  double get scaleHeight => sizeConfig.height / sizeConfig.baseSize.height;

  double setWidth(num width) =>
      width * scaleWidth; // get scaled width based on parent size
  double setHeight(num height) =>
      height * scaleHeight; // get scaled height based on parent size
  double setSp(num fontSize) =>
      fontSize * scaleWidth; // get scaled font size based on parent size
  double setMinSize(num size) =>
      size * min(scaleWidth, scaleHeight); // get min scaled size
}
