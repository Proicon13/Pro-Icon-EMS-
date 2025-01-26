import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../../Core/constants/app_assets.dart';
import '../../../../Core/entities/control_panel_mad.dart';
import '../../../../Core/theme/app_text_styles.dart';

class ControlPanelCard extends StatelessWidget {
  final ControlPanelMad mad;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const ControlPanelCard({
    required this.mad,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: context.sizeConfig.width,
        margin: EdgeInsets.only(right: context.setMinSize(10)),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(context.setMinSize(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: context.setMinSize(5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: context.sizeConfig.height * 0.26,
              padding: EdgeInsets.symmetric(horizontal: context.setMinSize(5)),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                border: isSelected
                    ? Border.all(
                        color: AppColors.primaryColor,
                        width: context.setMinSize(2))
                    : null,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(context.setMinSize(20)),
                    topLeft: Radius.circular(context.setMinSize(20))),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      "No. ${mad.madNo}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.fontSize12(context).copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                    isSelected
                        ? const CustomSvgVisual(
                            assetPath: Assets.assetsImagesMadSelectedIcon)
                        : const SizedBox.shrink()
                  ]),
            ),
            if (mad.client == null) ...[
              context.setMinSize(5).verticalSpace,
              CustomSvgVisual(
                assetPath: Assets.assetsImagesAssignUserIcon,
                width: context.setMinSize(25),
                height: context.setMinSize(25),
              ),
              context.setMinSize(8).verticalSpace,
              Text(
                "Assign User",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.fontSize12(context)
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
            if (mad.client != null) ...[
              // Details Column (User Name, Heart Rate, Calories)
              context.setMinSize(5).verticalSpace,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.person,
                          size: context.setMinSize(16), color: Colors.white),
                      context.setMinSize(5).horizontalSpace,
                      Text(
                        mad.client!.fullname!.split(" ")[0],
                        style: AppTextStyles.fontSize12(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  context.setMinSize(5).verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.favorite,
                          size: context.setMinSize(16), color: Colors.white),
                      context.setMinSize(5).horizontalSpace,
                      Text(
                        "${mad.heartRate ?? 0}",
                        style: AppTextStyles.fontSize12(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  context.setMinSize(5).verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSvgVisual(
                        assetPath: Assets.assetsImagesCaloriesIcon,
                        width: context.setMinSize(16),
                        height: context.setMinSize(16),
                      ),
                      context.setMinSize(5).horizontalSpace,
                      Text(
                        "${mad.caloriesBurnt ?? 0}",
                        style: AppTextStyles.fontSize12(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
            // blutooth row
            Row(children: [
              CustomSvgVisual(
                assetPath: mad.isBluetoothConnected!
                    ? Assets.assetsImagesBlutoothConnectedIcon
                    : Assets.assetsImagesBluetoothDisconnectedIcon,
                width: context.setMinSize(15),
                height: context.setMinSize(15),
              ),
              Text(
                  "${mad.isBluetoothConnected! ? "Connected" : "Disconnected"}",
                  style: AppTextStyles.fontSize12(context).copyWith(
                      color:
                          mad.isBluetoothConnected! ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500))
            ])
          ],
        ),
      ),
    );
  }
}
