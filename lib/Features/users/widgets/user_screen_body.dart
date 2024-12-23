import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/theme/app_colors.dart';
import '../../../Core/theme/app_text_styles.dart';

class UsersScreenBody extends StatelessWidget {
  const UsersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          40.h.verticalSpace,
          Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers and evenly spaces the texts
            children: [
              Text(
                "userManagment.screen.trainers".tr(),
                style: AppTextStyles.fontSize16.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              40.w.horizontalSpace,
              Text(
                "userManagment.screen.clients".tr(),
                style: AppTextStyles.fontSize16.copyWith(
                  color: AppColors.lightGreyColor,
                ),
              ),
            ],
          ),
          50.h.verticalSpace,
        ],
      ),
    );
  }
}
