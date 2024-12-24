import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/widgets/custom_svg_visual.dart';

import '../../../Core/constants/app_assets.dart';
import '../../../Core/theme/app_colors.dart';
import '../../../Core/widgets/custom_text_field.dart';

class SearchSection extends StatelessWidget {
  final void Function(String) onSearch;
  final void Function() onFilterPressed;
  final void Function() onAddPressed;

  const SearchSection({
    super.key,
    required this.onSearch,
    required this.onFilterPressed,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double searchBarHeight = 50.h; // Fixed height for search bar

    return Row(
      children: [
        // Search Bar
        Expanded(
          child: SizedBox(
            height: searchBarHeight,
            child: CustomTextField(
              name: 'searchBar',
              hintText: "userManagment.screen.searchHint".tr(),
              onChanged: (value) => onSearch(value ?? ''),
              keyboardInputType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.white71Color,
                size: 24.sp,
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: (searchBarHeight - 24.sp) / 2,
                horizontal: 10.w,
              ),
            ),
          ),
        ),

        10.w.horizontalSpace,

        // Filter Button
        InkWell(
          onTap: onFilterPressed,
          child: Container(
            height: searchBarHeight,
            width: 50.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const CustomSvgVisual(
              assetPath: Assets.assetsImagesFilterIcon,
            ),
          ),
        ),

        10.w.horizontalSpace,

        // Add Button
        InkWell(
          onTap: onAddPressed,
          child: Container(
            height: searchBarHeight,
            width: 50.w,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ),
      ],
    );
  }
}
