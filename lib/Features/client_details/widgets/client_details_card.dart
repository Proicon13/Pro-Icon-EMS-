import 'package:flutter/material.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/custom_circular_image.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/entities/client_entity.dart';
import '../../../Core/theme/app_colors.dart';

class ClientDetailsCard extends StatelessWidget {
  final ClientEntity client;

  const ClientDetailsCard({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      baseSize: const Size(398, 120),
      width: context.setMinSize(398),
      height: context.setMinSize(120),
      child: Builder(builder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            CustomCircularImage(
              width: context.setMinSize(65),
              height: context.setMinSize(65),
              imageUrl: client.image ?? "",
            ),
            context.setMinSize(12).horizontalSpace,
            // Left Section (Name and Phone)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Full Name
                  Text(
                    client.fullname ?? "",
                    style: AppTextStyles.fontSize18(context).copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  context.setMinSize(8).verticalSpace,
                  // Phone Number with Icon
                  Row(
                    children: [
                      CustomSvgVisual(
                        width: context.setMinSize(15),
                        height: context.setMinSize(15),
                        assetPath: Assets.assetsImagesPhoneIcon,
                      ),
                      context.setMinSize(10).horizontalSpace,
                      Flexible(
                        child: Text(
                          client.phone ?? "",
                          style: AppTextStyles.fontSize14(context).copyWith(
                            color: AppColors.white71Color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            context.setMinSize(40).horizontalSpace,
            // Divider
            Container(
              width: context.setMinSize(2),
              height: context.setMinSize(70),
              color: AppColors.lightGreyColor,
            ),
            context.setMinSize(20).horizontalSpace,
            CustomSvgVisual(
              width: context.setMinSize(20),
              height: context.setMinSize(70),
              assetPath: client.gender == "MALE"
                  ? Assets.assetsImagesMaleIcon
                  : Assets.assetsImagesFemaleIcon,
            ),

            context.setMinSize(12).horizontalSpace,
            // Right Section (Gender, Weight, and Height)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Gender: ${client.gender ?? "N/A"}",
                  style: AppTextStyles.fontSize14(context).copyWith(
                    color: Colors.white,
                  ),
                ),
                context.setMinSize(8).verticalSpace,
                Text(
                  "Weight: ${client.weight ?? "N/A"} kg",
                  style: AppTextStyles.fontSize14(context).copyWith(
                    color: Colors.white,
                  ),
                ),
                context.setMinSize(8).verticalSpace,
                Text(
                  "Height: ${client.height ?? "N/A"} cm",
                  style: AppTextStyles.fontSize14(context).copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
