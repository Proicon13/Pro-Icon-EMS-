import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

class SizeConstants {
  SizeConstants._();

  static kScaffoldPadding(BuildContext context) => EdgeInsets.symmetric(
        horizontal: context.setMinSize(16),
      );

  static kBottomNavBarPadding(BuildContext context) => EdgeInsets.symmetric(
        horizontal: context.setMinSize(16),
        vertical: context.setMinSize(15),
      );
  static kDefaultBorderRadius(BuildContext context) => BorderRadius.circular(
        context.setMinSize(8),
      );
}
