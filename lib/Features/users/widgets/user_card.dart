import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/entities/user_entity.dart';
import '../../../Core/theme/app_colors.dart';
import '../../../Core/theme/app_text_styles.dart';
import '../../../Core/widgets/custom_network_image.dart';
import '../../../Core/widgets/custom_svg_visual.dart';

double userAvatarSize(BuildContext context) => context.setMinSize(80);

abstract class UserCardBase extends StatelessWidget {
  const UserCardBase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizeConfig(
      baseSize: const Size(398, 132),
      width: context.setMinSize(398),
      height: context.setMinSize(132),
      child: Builder(builder: (context) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.setMinSize(20),
                vertical: context.setMinSize(20)),
            margin: EdgeInsets.only(bottom: context.setMinSize(10)),
            decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: SizeConstants.kDefaultBorderRadius(context)),
            child: buildContent(context),
          ),
        );
      }),
    );
  }

  Widget buildContent(BuildContext context);
}

class UserCardLoaded extends UserCardBase {
  final UserEntity user;
  final void Function() onEdit;
  final void Function() onDelete;

  const UserCardLoaded({
    super.key,
    required this.user,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget buildContent(BuildContext context) {
    final iconSize = context.setMinSize(18);
    final phoneIcon = CustomSvgVisual(
        width: iconSize,
        height: iconSize,
        assetPath: Assets.assetsImagesPhoneIcon);
    final emailIcon = CustomSvgVisual(
        width: iconSize,
        height: iconSize,
        assetPath: Assets.assetsImagesEmailIcon);
    final locationIcon = CustomSvgVisual(
        width: iconSize,
        height: iconSize,
        assetPath: Assets.assetsImagesAddressLocation);
    final editIcon = CustomSvgVisual(
        width: iconSize,
        height: iconSize,
        assetPath: Assets.assetsImagesEditIcon);
    final deleteIcon = CustomSvgVisual(
        width: iconSize,
        height: iconSize,
        assetPath: Assets.assetsImagesDeleteIcon);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Container(
                height: userAvatarSize(context),
                width: userAvatarSize(context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white71Color, // Border color
                    width: context.setMinSize(3), // Border width
                  ),
                ),
                child: ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: user.image ?? '',
                    errorAssetPath: Assets.assetsImagesLogo,
                  ),
                ),
              ),

              context.setMinSize(20).horizontalSpace,

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.fullname!,
                      style: AppTextStyles.fontSize16(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    context.setMinSize(10).verticalSpace,
                    Row(
                      children: [
                        emailIcon,
                        context.setMinSize(10).horizontalSpace,
                        Expanded(
                          child: Text(
                            user.email!,
                            style: AppTextStyles.fontSize14(context)
                                .copyWith(color: AppColors.white71Color),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    context.setMinSize(10).verticalSpace,
                    Row(
                      children: [
                        phoneIcon,
                        context.setMinSize(10).horizontalSpace,
                        Expanded(
                          child: Text(
                            user.phone!,
                            style: AppTextStyles.fontSize14(context)
                                .copyWith(color: AppColors.white71Color),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    context.setMinSize(10).verticalSpace,
                    Row(
                      children: [
                        locationIcon,
                        context.setMinSize(10).horizontalSpace,
                        Expanded(
                          child: Text(
                            "${user.city!.country.name} - ${user.city!.name}",
                            style: AppTextStyles.fontSize14(context)
                                .copyWith(color: AppColors.white71Color),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Action Icons
        Row(
          children: [
            InkWell(
              onTap: onEdit,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.setMinSize(5)),
                child: editIcon,
              ),
            ),
            InkWell(
              onTap: onDelete,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.setMinSize(5)),
                child: deleteIcon,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserCardLoading extends UserCardBase {
  const UserCardLoading({
    super.key,
  });

  @override
  Widget buildContent(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image Placeholder
                Container(
                  height: userAvatarSize(context),
                  width: userAvatarSize(context),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white71Color,
                  ),
                ),

                context.setMinSize(20).horizontalSpace,

                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Loading...',
                        style: AppTextStyles.fontSize16(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      10.h.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: context.setSp(14),
                                color: AppColors.white71Color,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      context.setMinSize(10).verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: context.setSp(14),
                                color: AppColors.white71Color,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      10.h.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: context.setSp(14),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
