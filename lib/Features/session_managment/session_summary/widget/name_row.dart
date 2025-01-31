import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/theme/app_text_styles.dart';
import '../../../../Core/widgets/custom_svg_visual.dart';

class NameRow extends StatelessWidget {
  final String userName;
  final String madsCount;

  NameRow({super.key, required this.userName, required this.madsCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ensures bounded width
      child: Row(
        children: [
          Expanded(
            child: Text(
              userName,
              style: AppTextStyles.fontSize16(context)
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis, // Prevents text overflow
            ),
          ),
          Row(
            children: [
              CustomSvgVisual(
                assetPath: Assets.assetsImagesMadsIcon,
                width: context.setMinSize(18),
                color: Colors.grey,
              ),
              context.setMinSize(10).horizontalSpace,
              Text(
                "MAD No : $madsCount",
                style: AppTextStyles.fontSize14(context)
                    .copyWith(color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
