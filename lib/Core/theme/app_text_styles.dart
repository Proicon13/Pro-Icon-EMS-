import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle fontSize24(BuildContext context) => TextStyle(
        fontSize: context.setSp(24),
        fontWeight: FontWeight.w700,
      );

  static TextStyle fontSize20(BuildContext context) => TextStyle(
        fontSize: context.setSp(20),
        fontWeight: FontWeight.w700,
      );

  static TextStyle fontSize18(BuildContext context) => TextStyle(
        fontSize: context.setSp(18),
        fontWeight: FontWeight.w400,
      );
  static TextStyle fontSize14(BuildContext context) => TextStyle(
        fontSize: context.setSp(14),
        fontWeight: FontWeight.w400,
      );
  static TextStyle fontSize16(BuildContext context) => TextStyle(
        fontSize: context.setSp(16),
        fontWeight: FontWeight.w400,
      );

  static TextStyle fontSize12(BuildContext context) => TextStyle(
        fontSize: context.setSp(12),
        fontWeight: FontWeight.w400,
      );
}
