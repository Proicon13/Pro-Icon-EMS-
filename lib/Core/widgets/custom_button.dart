import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';

import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle? style;
  final Color? color;
  final BorderSide? borderSide;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color,
      this.borderSide,
      this.style});

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      baseSize: const Size(398, 50),
      height: context.setMinSize(50),
      width: context.setMinSize(398),
      child: Builder(builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: context.sizeConfig.height,
          child: MaterialButton(
            onPressed: onPressed,
            padding: EdgeInsets.symmetric(
              vertical: context.setMinSize(15),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: SizeConstants.kDefaultBorderRadius(context),
                side: borderSide ?? BorderSide.none),
            color: color ?? AppColors.primaryColor,
            child: Text(text,
                style: style ??
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: context.setMinSize(16),
                    )),
          ),
        );
      }),
    );
  }
}
