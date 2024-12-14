import 'package:flutter/material.dart';

extension Spaces on num {
  SizedBox get verticalSpace => SizedBox(
        height: toDouble(),
      ); // vertical space
  SizedBox get horizontalSpace => SizedBox(
        width: toDouble(),
      ); // horizontal space
}
