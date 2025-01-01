import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              AppTextStyles.fontSize24(context).copyWith(color: Colors.white),
        ),
        context.setMinSize(20).verticalSpace,
        Text(
          subtitle,
          textAlign: TextAlign.left,
          maxLines: 2,
          style: AppTextStyles.fontSize14(context).copyWith(
              color: AppColors.white71Color, fontSize: context.setSp(12)),
        ),
      ],
    );
  }
}
