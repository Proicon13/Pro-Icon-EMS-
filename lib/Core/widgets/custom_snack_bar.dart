import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/constants/app_assets.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../theme/app_colors.dart';

enum AlertStatus { success, failure }

class CustomSnackBar extends StatelessWidget {
  final String message;
  final AlertStatus status;

  const CustomSnackBar({
    Key? key,
    required this.message,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String assetPath = status == AlertStatus.success
        ? Assets.assetsImagesSuccess
        : Assets.assetsImagesFailure;

    final Color statusColor =
        status == AlertStatus.success ? Colors.green : AppColors.primaryColor;

    return SizeConfig(
      baseSize: const Size(398, 75),
      width: context.setMinSize(398),
      height: context.setMinSize(75),
      child: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 0.03.sh),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                // Parent container for the snackbar
                Container(
                  width: context.sizeConfig.width, // 90% of the screen width
                  padding: EdgeInsets.symmetric(
                      vertical: context.setMinSize(15),
                      horizontal: context.setMinSize(5)),
                  decoration: BoxDecoration(
                    color: AppColors
                        .backgroundColor, // Your custom background color
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      context
                          .setMinSize(30)
                          .horizontalSpace, // Space to align text and icon correctly
                      // Status Icon
                      CustomSvgVisual(
                        assetPath: assetPath,
                        width: context.setMinSize(32),
                        height: context.setMinSize(32),
                      ),
                      context
                          .setMinSize(12)
                          .horizontalSpace, // Space between icon and text
                      // Message Text
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            message,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppTextStyles.fontSize14(context).copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Vertical Colored Bar
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: context.setMinSize(20),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.r),
                        bottomLeft: Radius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

void buildCustomAlert(BuildContext context, String message, Color color,
    [Duration? duration = const Duration(seconds: 2)]) {
  final status =
      color == Colors.green ? AlertStatus.success : AlertStatus.failure;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CustomSnackBar(
      message: message,
      status: status,
    ),
  );

  // Automatically dismiss the dialog after the specified duration
  Future.delayed(duration ?? const Duration(seconds: 1), () {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  });
}
