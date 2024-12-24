import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/theme/app_colors.dart';
import '../../../Core/theme/app_text_styles.dart';
import '../../../Core/widgets/custom_network_image.dart';
import '../../../Core/widgets/custom_svg_visual.dart';
import '../../../data/models/app_user_model.dart';

class UserCard extends StatelessWidget {
  final AppUserModel user;
  final void Function() onTap;
  final void Function() onEdit;
  final void Function() onDelete;
  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final phoneIcon =
        const CustomSvgVisual(assetPath: Assets.assetsImagesPhoneIcon);
    final emailIcon =
        const CustomSvgVisual(assetPath: Assets.assetsImagesEmailIcon);
    final locationIcon =
        const CustomSvgVisual(assetPath: Assets.assetsImagesAddressLocation);
    final editIcon =
        const CustomSvgVisual(assetPath: Assets.assetsImagesEditIcon);
    final deleteIcon =
        const CustomSvgVisual(assetPath: Assets.assetsImagesDeleteIcon);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: AppColors.darkGreyColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image
                  Container(
                    height: 80.h,
                    width: 80.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white71Color, // Border color
                        width: 3.w, // Border width
                      ),
                    ),
                    child: ClipOval(
                      child: CustomNetworkImage(
                        imageUrl: user.image ?? '',
                        errorAssetPath: Assets.assetsImagesLogo,
                      ),
                    ),
                  ),

                  20.w.horizontalSpace,

                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.fullname!,
                          style: AppTextStyles.fontSize16.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        10.h.verticalSpace,
                        Row(
                          children: [
                            emailIcon,
                            10.w.horizontalSpace,
                            Expanded(
                              child: Text(
                                user.email!,
                                style: TextStyle(
                                  fontSize: 14.sp,
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
                            phoneIcon,
                            10.w.horizontalSpace,
                            Expanded(
                              child: Text(
                                user.phone!,
                                style: TextStyle(
                                  fontSize: 14.sp,
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
                            locationIcon,
                            10.w.horizontalSpace,
                            Expanded(
                              child: Text(
                                "${user.city!.country.name} - ${user.city!.name}",
                                style: TextStyle(
                                  fontSize: 14.sp,
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

            // Action Icons
            Row(
              children: [
                InkWell(
                  onTap: onEdit,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: editIcon,
                  ),
                ),
                InkWell(
                  onTap: onDelete,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: deleteIcon,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
