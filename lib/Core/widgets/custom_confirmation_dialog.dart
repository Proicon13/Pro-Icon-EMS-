import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../constants/app_assets.dart';
import '../theme/app_text_styles.dart';
import 'custom_button.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String confirmationTitle;
  final void Function() onConfirm;
  final void Function()? onCancel;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.confirmationTitle,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            context.setMinSize(16)), // Same rounded corners
      ),
      backgroundColor: AppColors.backgroundColor, // Matching background color
      child: Container(
        width: context.sizeConfig.width * 0.75,
        height: context.sizeConfig.height * 0.42,
        padding: EdgeInsets.symmetric(
          horizontal: context.setMinSize(16),
        ), // Consistent padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            context.setMinSize(35).verticalSpace,
            // Icon Section
            CustomSvgVisual(
              assetPath: Assets.assetsImagesConfirmationIcon,
              width: context.setMinSize(80),
              height: context.setMinSize(80),
            ),
            context.setMinSize(45).verticalSpace, // Space between icon and text
            // Title Text
            Text(
              title,
              style: AppTextStyles.fontSize16(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            context
                .setMinSize(50)
                .verticalSpace, // Space between title and buttons
            // Confirm Button
            CustomButton(
              onPressed: onConfirm,
              text: confirmationTitle,
            ),
            context.setMinSize(16).verticalSpace, // Space between buttons
            // Cancel Button
            CustomButton(
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              text: "cancel".tr(),
              color: Colors.white,
              style: AppTextStyles.fontSize16(context).copyWith(
                color: AppColors.primaryColor,
                fontSize: context.setMinSize(16),
                fontWeight: FontWeight.w500,
              ),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: context.setMinSize(1.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
