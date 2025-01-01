import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class HaveAccountRow extends StatelessWidget {
  const HaveAccountRow({
    super.key,
    required this.title,
    required this.action,
    required this.onAction,
  });
  final String title;
  final String action;
  final Function() onAction;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.fontSize14(context)
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        context.setMinSize(5).horizontalSpace,
        GestureDetector(
          onTap: onAction,
          child: Text(
            action,
            style: AppTextStyles.fontSize14(context).copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
