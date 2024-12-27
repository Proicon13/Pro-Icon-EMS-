import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';

import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  const CustomButton(
      {super.key, required this.onPressed, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        vertical: context.setMinSize(15),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: SizeConstants.kDefaultBorderRadius(context),
      ),
      color: color ?? AppColors.primaryColor,
      child: Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: context.setMinSize(16),
          )),
    );
  }
}
