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
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          _buildBackgroundContainer(context),
          _buildHeaderSection(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundContainer(BuildContext context) {
    return Container(
      width: context.sizeConfig.width,
      margin: EdgeInsets.only(right: context.setMinSize(10)),
      padding: EdgeInsets.symmetric(horizontal: context.setMinSize(7)),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        border: isSelected
            ? Border.all(
                color: AppColors.primaryColor, width: context.setMinSize(2))
            : null,
        borderRadius: BorderRadius.circular(context.setMinSize(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (context.sizeConfig.height * 0.26).verticalSpace,
          if (mad.client == null)
            _buildAssignUserSection(context)
          else
            _buildDetailsSection(context),
          const Spacer(),
          _buildBluetoothStatusRow(context),
          context.setMinSize(9).verticalSpace,
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        height: context.sizeConfig.height * 0.26,
        width: context.sizeConfig.width,
        padding: EdgeInsets.symmetric(horizontal: context.setMinSize(5)),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(context.setMinSize(20)),
            topLeft: Radius.circular(context.setMinSize(20)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "MAD ${mad.madNo}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.fontSize12(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            isSelected
                ? CustomSvgVisual(
                    assetPath: Assets.assetsImagesMadSelectedIcon,
                    width: context.setMinSize(15),
                    height: context.setMinSize(15),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignUserSection(BuildContext context) {
    return Column(
      children: [
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
          style: AppTextStyles.fontSize12(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.setMinSize(3).verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.person,
                size: context.setMinSize(16), color: Colors.white),
            context.setMinSize(5).horizontalSpace,
            Expanded(
              child: Text(
                mad.client!.fullname!.split(" ")[0],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.fontSize12(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
            Expanded(
              child: Text(
                "${mad.heartRate ?? 0}",
                style: AppTextStyles.fontSize12(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            context.setMinSize(8).horizontalSpace,
            Container(
              width: context.setMinSize(10),
              height: context.setMinSize(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    mad.isHeartRateSensorConnected! ? Colors.green : Colors.red,
              ),
            )
          ],
        ),
        context.setMinSize(5).verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSvgVisual(
              assetPath: Assets.assetsImagesCaloriesIcon,
              width: context.setMinSize(18),
              height: context.setMinSize(18),
            ),
            context.setMinSize(6).horizontalSpace,
            Expanded(
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                "${mad.caloriesBurnt ?? 0}",
                style: AppTextStyles.fontSize12(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBluetoothStatusRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSvgVisual(
          assetPath: mad.isBluetoothConnected!
              ? Assets.assetsImagesBlutoothConnectedIcon
              : Assets.assetsImagesBluetoothDisconnectedIcon,
          width: context.setMinSize(15),
          height: context.setMinSize(15),
        ),
        context.setMinSize(5).horizontalSpace,
        Expanded(
          child: Text(
            mad.isBluetoothConnected! ? " Connected" : " No connection",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTextStyles.fontSize12(context).copyWith(
              color: mad.isBluetoothConnected! ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
