import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';

import '../../../../Core/theme/app_text_styles.dart';

  class StartDateWidget extends StatelessWidget {
  const StartDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: context.setMinSize(0) , right: context.setMinSize(90)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween  ,
            children: [
              Text(
                "Start date",
                style: AppTextStyles.fontSize16(context).copyWith(color: Colors.white),
              ),
              Text(
                "End date",
                style: AppTextStyles.fontSize16(context).copyWith(color: Colors.white),
              ),
            ],
          ),
          context.setMinSize(15).verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "1-2-2025",
                style: AppTextStyles.fontSize16(context).copyWith(color: Colors.grey),
              ),
              Text(
                "1-2-2025",
                style: AppTextStyles.fontSize16(context).copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
